import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../resources/models/models.dart';
import '../../utils/utils.dart';
import '../base/base.dart';
import '../../resources/repositories/auth.dart';

class LoginViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  LoginViewModel({@required this.authRepository});

  Future init() async {
    isLoading = true;
    isLoading = false;
  }

  Future<void> login(String email, String password) async {
    _showLoadingDialog();
    final loginResponse = await authRepository.login(email, password);
    if (loginResponse.statusCode == 200) {
      await SharedPref.setUser(User.fromJson(loginResponse.data));
      await Navigator.pushNamed(context, Routes.home);
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
    Navigator.pop(context);
  }

  void _showLoadingDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(width: 20),
                    Text('Loading...')
                  ],
                ),
              ),
            ),
          );
        });
  }
}
