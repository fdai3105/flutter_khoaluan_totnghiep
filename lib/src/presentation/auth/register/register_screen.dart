import 'package:flutter/material.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';
import '../../widgets/widgets.dart';
import '../../../configs/configs.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: BaseWidget<RegisterViewModel>(
          onViewModelReady: (vm) {
            vm.init();
          },
          viewModel: RegisterViewModel(authRepository: AuthRepository()),
          builder: (context, vm, child) {
            return _mobile(context, vm);
          },
        ),
      ),
    );
  }

  Widget _mobile(BuildContext context, RegisterViewModel vm) {
    final _formKey = GlobalKey<FormState>();

    String name;
    String email;
    String phone;
    String password;
    String confirmPassword;
    int select;

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
                    onChanged: (value) => {name = value},
                    hint: 'Your name',
                    value: 'Dai Mobile',
                    hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                    color: Colors.black26,
                    focusColor: Colors.black54,
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  const SizedBox(height: 20),
                  WidgetInput(
                    onChanged: (value) => {email = value},
                    value: 'fdai3105@gmail.com',
                    hint: 'Email',
                    hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                    color: Colors.black26,
                    focusColor: Colors.black54,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 20),
                  WidgetInput(
                    onChanged: (value) => {phone = value},
                    hint: 'Phone number',
                    value: '078777230926',
                    hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                    color: Colors.black26,
                    focusColor: Colors.black54,
                    prefixIcon: const Icon(Icons.phone_outlined),
                  ),
                  const SizedBox(height: 20),
                  WidgetInput(
                    onChanged: (value) => {password = value},
                    hint: 'Password',
                    value: 'passwordFlutter',
                    hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                    color: Colors.black26,
                    focusColor: Colors.black54,
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  const SizedBox(height: 20),
                  WidgetInput(
                    onChanged: (value) => {confirmPassword = value},
                    hint: 'Confirm password',
                    value: 'passwordFlutter',
                    hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                    color: Colors.black26,
                    focusColor: Colors.black54,
                    prefixIcon: const Icon(Icons.lock_outline),
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
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (password == confirmPassword) {
                            vm.register(name, email, phone, password, 1);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(':((')));
                          }
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account? ",
              style: TextStyle(
                color: AppColors.dark45,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
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
    );
  }
}
