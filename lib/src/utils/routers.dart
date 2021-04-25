import 'package:flutter/material.dart';
import '../presentation/presentation.dart';

class Routes {
  Routes._();

  static const String login = '/login_screen';
  static const String register = '/register_screen';
  static const String home = '/home_screen';
  static const String forgot = '/forgot_screen';
  static const String resendMail = '/resend_mail_screen';

  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String selectAddress = '/select-address';
  static const String orderSuccess = '/order-success';
  static const String order = '/order';
  static const String favorite = '/favorite';

  static const String category = '/category';
  static const String product = '/product';

  static const String address = '/address';
  static const String city = '/city';

  static final Map<String, WidgetBuilder> routes = {
    login: (_) => LoginScreen(),
    register: (_) => RegisterScreen(),
    forgot: (_) => ForgotScreen(),
    resendMail: (_) => ResendMailScreen(),
    cart: (_) => CartScreen(),
    checkout: (_) => const CheckoutScreen(),
    selectAddress: (_) => const SelectAddressScreen(),
    orderSuccess: (_) => OrderSuccessScreen(),
    order: (_) => OrderScreen(),
    favorite:(_) => FavoriteScreen(),
    home: (_) => DashboardScreen(),
    category: (_) => const CategoryScreen(),
    product: (_) => const ProductScreen(),
    address: (_) => AddressScreen(),
    city: (_) => CityScreen(),
  };
}
