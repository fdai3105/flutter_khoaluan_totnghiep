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
    final _formKey = GlobalKey<FormState>();
    String email;
    String password;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: BaseWidget(
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
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: _formKey,
                      child: Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetInput(
                            onChanged: (value) => {email = value},
                            hint: 'Email',
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.w600),
                            color: Colors.black26,
                            focusColor: Colors.black54,
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          const SizedBox(height: 20),
                          WidgetInput(
                            onChanged: (value) => {password = value},
                            hint: 'Password',
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.w600),
                            color: Colors.black26,
                            focusColor: Colors.black54,
                            prefixIcon: const Icon(Icons.lock_outline),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  vm.login(email, password);
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppStyles.radiusNormal,
                                ),
                              ),
                              child: const SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.forgot);
                            },
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: AppColors.hintDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: AppColors.hintDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
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
