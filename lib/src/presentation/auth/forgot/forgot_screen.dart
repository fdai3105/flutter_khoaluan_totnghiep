import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../../resources/resources.dart';
import '../../../utils/utils.dart';
import '../../presentation.dart';

class ForgotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String email;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: WidgetAppBar(title: 'find_your_account'.tr),
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
                  Text(
                    'enter_your_email'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  WidgetInput(
                    onChanged: (value) => email = value,
                    hint: 'email'.tr,
                  ),
                  const SizedBox(height: 20),
                  WidgetButton(
                    onTap: () {
                      if (email != null) {
                        // todo
                        final exp = RegExp(RegexPattern.email);
                        if (exp.hasMatch(email)) {
                          vm.forgotPassword(email);
                        } else {
                          snackBar(context, 'incorrect_email'.tr);
                        }
                      } else {
                        snackBar(context, 'email_empty'.tr);
                      }
                    },
                    text: 'find_your_account'.tr,
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
