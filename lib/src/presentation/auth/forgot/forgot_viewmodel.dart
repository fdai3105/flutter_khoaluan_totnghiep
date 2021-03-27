import 'package:flutter/material.dart';
import '../../../resources/repositories/auth.dart';

import '../../base/base.dart';

class ForgotViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  ForgotViewModel({@required this.authRepository});

  void init() {
    isLoading = false;
  }

  Future forgotPassword(String email) async {
    final response = await authRepository.forgotPassword(email);
    if (response.statusCode == 200) {
      _showDialog();
    } else if (response.statusCode == 422) {
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
            title: const Text('Reset your password'),
            content: const Text(
              'We have sent a password recover link to your email',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }
}
