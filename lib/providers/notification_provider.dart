import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:learning_course2/models/notifciations/notification_model.dart';
import 'package:learning_course2/models/notifciations/notification_response_model.dart';
import 'package:learning_course2/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  NotificationResponseModel? notificationResponseModel;
  List<NotificationModel> notificationsList = [];

  bool isLoading = false;
  bool isLoadingMore = false;
  bool isDeleting = false;
  String? errorMessage;

  int page = 1;
  int pageSize = 20;
  bool hasMore = true;

  int get unread => notificationResponseModel?.unreadCount ?? 0;

  //For Read more button toggling

  Map<int, bool> expandesNotifications = {};
  bool isExpanded(int id) {
    return expandesNotifications[id] ?? false;
  }

  void toggleMore(int id) {
    expandesNotifications[id] = !isExpanded(id);
    notifyListeners();
  }

  Future<void> getNotifications() async {
    try {
      isLoading = true;
      errorMessage = null;
      page = 1;
      hasMore = true;
      notifyListeners();
      final response = await _notificationService.getNotifications(
        page: page,
        pageSize: pageSize,
      );
      log(response.unreadCount.toString());
      notificationResponseModel = response;
      notificationsList = response.notifications;

      hasMore = response.next != null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreNotifications() async {
    if (isLoadingMore || !hasMore || isLoading) return;

    try {
      isLoadingMore = true;
      notifyListeners();

      final nextPage = page + 1;
      final response = await _notificationService.getNotifications(
        page: nextPage,
        pageSize: pageSize,
      );
      notificationsList.addAll(response.notifications);
      notificationResponseModel = response;
      page = nextPage;

      hasMore = response.next != null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<bool> deleteNot({required NotificationModel notification}) async {
    try {
      isDeleting = true;
      errorMessage = null;
      notifyListeners();

      await _notificationService.deleteNotification(
        notificationId: notification.id.toString(),
      );
      notificationsList.removeWhere((item) => item.id == notification.id);

      if (!notification.isSeen) {
        final currentCount = notificationResponseModel?.unreadCount ?? 0;
        if (currentCount > 0) {
          notificationResponseModel?.unreadCount = currentCount - 1;
        }
      }
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isDeleting = false;
      notifyListeners();
    }
  }

  Future<void> deleteAll() async {
    while (notificationsList.isNotEmpty) {
      final success = await deleteNot(notification: notificationsList.first);
      if (!success) return;
    }
  }
}
