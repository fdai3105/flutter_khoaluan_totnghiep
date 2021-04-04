import 'package:flutter/material.dart';
import '../presentation/presentation.dart';

class Routes {
  Routes._();

  static const String login = '/login_screen';
  static const String register = '/register_screen';
  static const String home = '/home_screen';
  static const String forgot = '/forgot_screen';
  static const String cart = '/cart';
  static const String category = '/category';
  static const String product = '/product';

  static const String city = '/city';

  static final Map<String, WidgetBuilder> routes = {
    login: (_) => LoginScreen(),
    register: (_) => RegisterScreen(),
    forgot: (_) => ForgotScreen(),
    cart: (_) => CartScreen(),
    home: (_) => HomeTab(),
    category: (_) => const CategoryScreen(),
    product: (_) => const ProductScreen(),
    city: (_) => CityScreen(),
  };
}
