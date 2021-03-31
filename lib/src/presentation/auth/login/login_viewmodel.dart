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
    if (loginResponse.statusCode == 200) {
      await SharedPref.setUser(User.fromJson(loginResponse.data));
      await pushNewScreen(context, screen: DashboardScreen());
      loadingDialog.hide();
    } else if (loginResponse.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loginResponse.data['message'] ?? "")));
    } else if (loginResponse.statusCode == 422) {
      var errors = '';
      Map.from(loginResponse.data['errors']).forEach((key, value) {
        final s = value.toString().substring(1, value.toString().length - 1);
        errors += '$s';
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errors ?? "")));
    }

    loadingDialog.hide();
  }
}
