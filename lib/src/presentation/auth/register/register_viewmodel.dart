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

  Future register(String name, String email, String phone, String password,
      int gender) async {
    final dialog = DialogLoading.of(context)..show();

    final user =
        await authRepository.register(name, email, phone, password, gender);
    if (user.statusCode == 200) {
      Navigator.pop(context);
    } else if (user.statusCode == 422) {
      final errors = Error.fromJson(user.data);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errors.message ?? "")));
    }
    dialog.hide();
  }
}

