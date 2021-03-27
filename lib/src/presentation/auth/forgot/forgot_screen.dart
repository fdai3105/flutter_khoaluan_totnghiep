import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';
import '../../../resources/resources.dart';
import '../../../configs/configs.dart';
import '../../presentation.dart';

class ForgotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Account'),
        backgroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: BaseWidget<ForgotViewModel>(
          viewModel: ForgotViewModel(authRepository: AuthRepository()),
          onViewModelReady: (vm) {},
          builder: (context, vm, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Enter Your Email',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    onChanged: (value) => email = value,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (email != null) {
                        final exp = RegExp(RegexPattern.email);
                        if (exp.hasMatch(email)) {
                          vm.forgotPassword(email);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primary,
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Find Your Account',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
