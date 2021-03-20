class AppEndpoint {
  AppEndpoint._();

  static const String base = 'http://192.168.1.3:8000/api/';

  ///
  static const String register = 'register';
  static const String login = 'login';
  static const String forgotPassword = 'password/email';

  ///
  static const String getProducts = 'product';
}
