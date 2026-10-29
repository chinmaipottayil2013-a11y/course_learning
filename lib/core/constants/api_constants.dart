class ApiConstants {
  static bool isProduction = false;
  static final String devBaseUrl = 'https://dadishaapi.kodhatch.com/';
  static final String productionUrl = '';
  static String get baseUrl => isProduction ? productionUrl : devBaseUrl;
  static String get courseListUrl => '${baseUrl}api/learning/all-courses/';
  static String get detailsUrl => '${baseUrl}api/learning/course-detail/';
  static String get loginUrl => '${baseUrl}user/individual-login/';
  static String get cartUrl => '${baseUrl}api/learning/cart-page/';
  static String get addToCarUrl => '${baseUrl}api/learning/add-to-cart/';
  static String get deleteFromCart =>
      '${baseUrl}api/learning/remove-from-cart/';
  static String get refreshUrl => '${baseUrl}user/token/refresh/';
  static String get courseByRegionUrl => '${baseUrl}api/learning/all-regions/';
  static String get addToFavouriteUrl =>
      '${baseUrl}api/learning/add-to-favourite/';
  static String get showFavouriteUrl =>
      '${baseUrl}api/learning/favourites-list/';
  static String get paymentUrl =>
      '${baseUrl}api/payments/learning/payment-request/';
  static String get verifyPayment => '${baseUrl}api/learning/checkout-page/';
  static String get enrolledCourses =>
      '${baseUrl}api/learning/enrolled-courses/';
}
