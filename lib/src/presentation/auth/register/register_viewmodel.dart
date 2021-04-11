import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  RegisterViewModel({@required this.authRepository});

  void init() {
    isLoading = false;
  }

  bool _validation(
    String name,
    String email,
    String phone,
    String password,
    String confirmPassword,
    int gender,
  ) {
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password not match together')));
      return false;
    }

    return true;
  }

  Future register(
    String name,
    String email,
    String phone,
    String password,
    String confirmPassword,
    int gender,
  ) async {
    if (!_validation(name, email, phone, password, confirmPassword, gender)) {
      return;
    }

    final dialog = DialogLoading.of(context)..show();
    final userRepo =
        await authRepository.register(name, email, phone, password, gender);
    dialog.hide();

    if (userRepo.statusCode == 200) {
      Navigator.pop(context);
    } else if (userRepo.statusCode == 422) {
      var msg = '';
      Map.from(userRepo.data['errors']).forEach((key, value) {
        msg +=
            '${value.toString().substring(1, value.toString().length - 1)}\n';
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg.substring(0, msg.length - 1))));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(userRepo.data)));
    }
  }
}
