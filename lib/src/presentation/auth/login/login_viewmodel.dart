import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../presentation.dart';
import '../../../utils/utils.dart';
import '../../../resources/resources.dart';

class LoginViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  LoginViewModel({@required this.authRepository});

  Future init() async {
    isLoading = true;
    isLoading = false;
  }

  Future<void> login(String email, String password) async {
    final loadingDialog = DialogLoading.of(context)..show();

    final loginResponse = await authRepository.login(email, password);
    loadingDialog.hide();
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
