// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// Project imports:
import '../../../resources/resources.dart';
import '../../../utils/utils.dart';
import '../../presentation.dart';

class LoginViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  LoginViewModel({@required this.authRepository});

  Future init() async {
    isLoading = true;
    isLoading = false;
  }

  Future<void> login(String email, String password) async {
    if (email == null || password == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please check your input')));
      return;
    }

    final dlLoading = DialogLoading.of(context)..show();
    final loginResponse = await authRepository.login(email, password);
    dlLoading.hide();
    if (loginResponse.statusCode == 200) {
      await SharedPref.setUser(User.fromJson(loginResponse.data));
      await pushNewScreen(context, screen: DashboardScreen());
    } else if (loginResponse.statusCode == 422) {
      print(loginResponse.data);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loginResponse.data['message'] ?? "")));
    }
  }
}
