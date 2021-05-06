// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../configs/configs.dart';
import '../../../resources/repositories/auth.dart';
import '../../../utils/utils.dart';
import '../../base/base.dart';
import '../../widgets/widgets.dart';
import 'login.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email;
    String password;

    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: const WidgetAppBar(),
      body: SafeArea(
        top: false,
        child: BaseWidget<LoginViewModel>(
          viewModel: LoginViewModel(authRepository: AuthRepository()),
          onViewModelReady: (vm) {
            vm.init();
          },
          builder: (context, vm, child) {
            return Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'login_title'.tr,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'login_desc'.tr,
                        ),
                        const SizedBox(height: 20),
                        WidgetInput(
                          onChanged: (value) => {email = value},
                          hint: 'email'.tr,
                        ),
                        const SizedBox(height: 20),
                        WidgetInput(
                          onChanged: (value) => {password = value},
                          hint: 'password'.tr,
                        ),
                        const SizedBox(height: 20),
                        WidgetButton(
                          onTap: () => vm.login(email, password),
                          text: 'login'.tr,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.forgot);
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            'forgot_password'.tr,
                            style: theme.textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "sign_up_title".tr,
                      style: theme.textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.register);
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'sign_up'.tr,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
