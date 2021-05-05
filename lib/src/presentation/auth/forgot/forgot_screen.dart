import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/utils/utils.dart';
import 'package:regexpattern/regexpattern.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class ForgotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String email;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: const WidgetAppBar(title: 'Find your account'),
      body: SafeArea(
        child: BaseWidget<ForgotViewModel>(
          viewModel: ForgotViewModel(authRepository: AuthRepository()),
          onViewModelReady: (vm) {},
          builder: (context, vm, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Enter Your Email',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  WidgetInput(
                    onChanged: (value) => email = value,
                    hint: 'Email',
                  ),
                  const SizedBox(height: 20),
                  WidgetButton(
                    onTap: () {
                      if (email != null) {
                        final exp = RegExp(RegexPattern.email);
                        if (exp.hasMatch(email)) {
                          vm.forgotPassword(email);
                        }
                      } else {
                        snackBar(context, 'Please enter your email');
                      }
                    },
                    text: 'Find Your Account',
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
