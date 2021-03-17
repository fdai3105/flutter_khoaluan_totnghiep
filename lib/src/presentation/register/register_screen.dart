import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../configs/configs.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int select;
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
                      hint: 'Your name',
                      hintStyle: TextStyle(fontWeight: FontWeight.w600),
                      color: Colors.black26,
                      focusColor: Colors.black54,
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    const SizedBox(height: 20),
                    const WidgetInput(
                      hint: 'Email',
                      hintStyle: TextStyle(fontWeight: FontWeight.w600),
                      color: Colors.black26,
                      focusColor: Colors.black54,
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 20),
                    const WidgetInput(
                      hint: 'Phone number',
                      hintStyle: TextStyle(fontWeight: FontWeight.w600),
                      color: Colors.black26,
                      focusColor: Colors.black54,
                      prefixIcon: Icon(Icons.phone_outlined),
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
                    const WidgetInput(
                      hint: 'Confirm password',
                      hintStyle: TextStyle(fontWeight: FontWeight.w600),
                      color: Colors.black26,
                      focusColor: Colors.black54,
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: select,
                              onChanged: (value) {},
                            ),
                            const Text('male'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: select,
                              onChanged: (value) {},
                            ),
                            const Text('female'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
                            'Register',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
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
                  "Already have an account? ",
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
                  child: const Text(
                    'Login',
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
