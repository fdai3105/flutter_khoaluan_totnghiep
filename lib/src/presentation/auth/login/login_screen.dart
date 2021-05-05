import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils.dart';
import '../../base/base.dart';
import 'login.dart';
import '../../../resources/repositories/auth.dart';
import '../../widgets/widgets.dart';
import '../../../configs/configs.dart';

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
                        const Text(
                          'Welcome back',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Log in to your account',
                        ),
                        const SizedBox(height: 20),
                        WidgetInput(
                          onChanged: (value) => {email = value},
                          hint: 'Email',
                        ),
                        const SizedBox(height: 20),
                        WidgetInput(
                          onChanged: (value) => {password = value},
                          hint: 'Password',
                        ),
                        const SizedBox(height: 20),
                        WidgetButton(
                          onTap: () => vm.login(email, password),
                          text: 'Login',
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
                            'Forgot password?',
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
                      "Don't have an account? ",
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
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
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
