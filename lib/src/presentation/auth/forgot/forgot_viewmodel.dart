import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../resources/repositories/auth.dart';
import '../../base/base.dart';
import '../../presentation.dart';

class ForgotViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  ForgotViewModel({@required this.authRepository});

  void init() {
    isLoading = false;
  }

  Future forgotPassword(String email) async {
    final dialog = DialogLoading.of(context)..show();
    final response = await authRepository.forgotPassword(email);
    dialog.hide();

    if (response.statusCode == 200) {
      _showDialog();
    } else if (response.statusCode == 422) {
      print(response.data);
      var s = '';
      Map.from(response.data['errors']).forEach((key, value) {
        s += '$value \n';
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(s ?? '')));
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Text('reset_password'.tr),
            content:  Text(
              'reset_password_desc'.tr,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }
}
