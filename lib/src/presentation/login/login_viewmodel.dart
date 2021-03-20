import 'package:flutter/cupertino.dart';
import '../../utils/utils.dart';
import '../base/base.dart';
import '../../resources/repositories/auth.dart';

class LoginViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  LoginViewModel({@required this.authRepository});

  void init() async {}

  void login(String email, String password) async {
    isLoading = true;
    final user = await authRepository.login(email, password);
    if (user != null) {
      print(user.accessToken);
      await SharedPref.setUser(user);
      await Navigator.pushNamed(context, Routes.home);
    }
    isLoading = false;
  }
}
