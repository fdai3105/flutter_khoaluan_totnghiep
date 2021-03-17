import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../configs/configs.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WidgetInput(
                      hint: 'Email',
                      hintStyle: TextStyle(fontWeight: FontWeight.w600),
                      color: Colors.black26,
                      focusColor: Colors.black54,
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 20),
                    const WidgetInput(
                      hint: 'Password',
                      hintStyle: TextStyle(fontWeight: FontWeight.w600),
                      color: Colors.black26,
                      focusColor: Colors.black54,
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {},
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
                      onPressed: () {},
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
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
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
        ),
      ),
    );
  }
}
