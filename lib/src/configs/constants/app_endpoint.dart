class AppEndpoint {
  AppEndpoint._();

  static const String domain = 'http://e9ee0e95d854.ngrok.io/';
  static const String base = '$domain' 'api/';

  ///
  static const String register = 'register';
  static const String login = 'login';
  static const String forgotPassword = 'password/email';
  static const String sendVerifyMail = 'resend-email';
  static const String editUser = 'user-edit';
  static const String hasVerifyEmail = 'has-verified-email';

  ///
  static const String getAddress = 'address';

  ///
  static const String getProduct = 'product/';
  static const String getProducts = 'product';
  static const String getNewProducts = 'new-product';
  static const String getPopularProducts = 'popular-product';
  static const String getSaleProducts = 'sale-product';
  static const String getProductsByParentCategory =
      'product-by-parent-category/';
  static const String getProductsByCategory = 'product-by-category/';
  static const String searchProduct = 'search-product';
  static const String getSimilarProducts = 'similar-product/';

  ///
  static const String getCategories = 'category';
  static const String getParentCategories = 'parent-category';
  static const String getSubCategories = 'get-sub-category/';

  ///
  static const String getRatingByProduct = 'rating-by-product/';
  static const String getCommentsByProduct = 'comment-by-product/';

  ///
  static const String checkout = 'checkout';
  static const String getOrders = 'orders';
  static const String getOrderDetail = 'order/';
}
