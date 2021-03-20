import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../resources/models/models.dart';
import '../../utils/utils.dart';
import '../base/base.dart';
import '../../resources/repositories/auth.dart';

class LoginViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  LoginViewModel({@required this.authRepository});

  void init() async {}

  Future<void> login(String email, String password) async {
    isLoading = true;
    final loginResponse = await authRepository.login(email, password);
    if (loginResponse.statusCode == 200) {
      await SharedPref.setUser(User.fromJson(loginResponse.data));
      await Navigator.pushNamed(context, Routes.home);
    } else if (loginResponse.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loginResponse.data['message'] ?? "")));
    } else if (loginResponse.statusCode == 422) {
      String errors = '';
      Map.from(loginResponse.data['errors']).forEach((key, value) {
        final s = value.toString().substring(1, value.toString().length - 1);
        errors += '$s';
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errors ?? "")));
    }
    isLoading = false;
  }
}
