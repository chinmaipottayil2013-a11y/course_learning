import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:learning_course2/core/constants/string_constants.dart';
import 'package:learning_course2/core/navigation/navigation_service.dart';
import 'package:learning_course2/services/authentication_service.dart';

class ApiClient extends http.BaseClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  final http.Client _client;
  final AuthenticationService _authenticationService;

  bool _isRefreshing = false;
  Completer<bool>? _refreshCompleter;

  ApiClient._internal({http.Client? client, AuthenticationService? authenticationService})
      : _client = client ?? http.Client(),
        _authenticationService = authenticationService ?? AuthenticationService();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Get current access token
    final accessToken = StringConstants.accessToken.isNotEmpty
        ? StringConstants.accessToken
        : await _authenticationService.getAccessToken();

    // Cache in memory and add access token
    if (accessToken != null && accessToken.isNotEmpty) {
      StringConstants.accessToken = accessToken;
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Make original request
    final response = await _client.send(request);

    // If request is successful, return it.
    if (response.statusCode != 401) {
      return response;
    }

    log('401 received for ${request.url}. Access token may be expired.');

    // Don't refresh if this request itself is the login/refresh endpoint.
    final path = request.url.path;
    if (path.contains('individual-login') || path.contains('token/refresh')) {
      return response;
    }

    // Refresh token
    final refreshSuccessful = await _refreshToken();

    if (!refreshSuccessful) {
      log('Token refresh failed. Logging out user.');
      await _authenticationService.logout();
      NavigationService.navigateToLogin();
      return response;
    }

    log('Token refreshed successfully. Retrying original request...');

    // Get newly saved access token
    final newAccessToken = StringConstants.accessToken.isNotEmpty
        ? StringConstants.accessToken
        : (await _authenticationService.getAccessToken()) ?? '';

    if (newAccessToken.isEmpty) {
      log('New access token is empty. Logging out.');
      await _authenticationService.logout();
      NavigationService.navigateToLogin();
      return response;
    }

    // Clone the original request
    final retryRequest = _copyRequest(request);

    // Add new token
    retryRequest.headers['Authorization'] = 'Bearer $newAccessToken';

    // Retry request
    return _client.send(retryRequest);
  }

  Future<bool> _refreshToken() async {
    // If another API call is already refreshing, wait for that refresh operation.
    if (_isRefreshing) {
      log('Waiting for ongoing token refresh...');
      return await (_refreshCompleter?.future ?? Future.value(false));
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<bool>();

    try {
      final result = await _authenticationService.refreshAccessToken();
      if (!_refreshCompleter!.isCompleted) {
        _refreshCompleter!.complete(result);
      }
      return result;
    } catch (e) {
      log('Refresh exception: $e');
      if (!_refreshCompleter!.isCompleted) {
        _refreshCompleter!.complete(false);
      }
      return false;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }

  http.Request _copyRequest(http.BaseRequest request) {
    if (request is http.Request) {
      final newRequest = http.Request(request.method, request.url);

      newRequest.headers.addAll(request.headers);
      newRequest.bodyBytes = request.bodyBytes;
      newRequest.followRedirects = request.followRedirects;
      newRequest.maxRedirects = request.maxRedirects;
      newRequest.persistentConnection = request.persistentConnection;

      return newRequest;
    }

    throw UnsupportedError(
      'Request type ${request.runtimeType} is not supported for retry.',
    );
  }

  @override
  void close() {
    _client.close();
  }
}
