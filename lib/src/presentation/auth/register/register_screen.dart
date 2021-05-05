import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';
import '../../widgets/widgets.dart';
import '../../../configs/configs.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const WidgetAppBar(title: 'Register'),
      body: SafeArea(
        child: BaseWidget<RegisterViewModel>(
          onViewModelReady: (vm) {
            vm.init();
          },
          viewModel: RegisterViewModel(authRepository: AuthRepository()),
          builder: (context, vm, child) {
            return Padding(
              padding: AppStyles.paddingBody,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  LinearPercentIndicator(
                    percent: vm.percent(),
                    animation: true,
                    animateFromLastPercent: true,
                    animationDuration: 200,
                    progressColor: AppColors.primary,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: PageView(
                      controller: vm.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) => vm.pageIndex = index,
                      children: bodies( context, vm),
                    ),
                  ),
                  WidgetButton(
                    onTap: () => vm.nextPage(),
                    text:
                        vm.pageIndex + 1 == bodies(context,vm).length ? 'Finish' : 'Next',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> bodies(BuildContext context, RegisterViewModel vm) {
    return [
      _namedBody(context, vm),
      _emailBody(context, vm),
      _phoneBody(context, vm),
      _genderBody(context, vm),
      _passwordBody(context, vm),
      _finishBody(context, vm),
    ];
  }

  Widget _namedBody(BuildContext context, RegisterViewModel vm) {
    final theme =Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
         Text(
          'What\'t your name?',
          style: theme.textTheme.bodyText1
        ),
        const SizedBox(height: 10),
        Text(
          'Enter the name you use in real life.',
          style: theme.textTheme.subtitle1,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            WidgetInput(
              onChanged: (value) {
                vm.name = value;
              },
              hint: 'First name',
            ),
            const SizedBox(width: 20),
            WidgetInput(
              onChanged: (value) {
                vm.name += value;
              },
              hint: 'Last name',
            ),
          ],
        ),
      ],
    );
  }

  Widget _emailBody(BuildContext context, RegisterViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        const Text(
          'What\'t your email address?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Adding an email helps you keep your account secure, contacts and more.',
          style: TextStyle(
            color: AppColors.dark45,
          ),
        ),
        const SizedBox(height: 30),
        WidgetInput(onChanged: (value) => vm.email = value, hint: 'Email'),
      ],
    );
  }

  Widget _phoneBody(BuildContext context, RegisterViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        const Text(
          'Enter your mobile number',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Enter the mobile number where you can be reached.',
          style: TextStyle(
            color: AppColors.dark45,
          ),
        ),
        const SizedBox(height: 30),
        WidgetInput(
            onChanged: (value) => vm.phone = value, hint: 'Mobile number'),
      ],
    );
  }

  Widget _genderBody(BuildContext context, RegisterViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        const Text(
          'What\'s your gender?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Radio(
            value: 1,
            groupValue: vm.gender,
            onChanged: (value) => vm.gender = value,
            activeColor: AppColors.primary,
          ),
          title: const Text('Male'),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Radio(
            value: 2,
            groupValue: vm.gender,
            onChanged: (value) => vm.gender = value,
            activeColor: AppColors.primary,
          ),
          title: const Text('Female'),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Radio(
            value: 9,
            groupValue: vm.gender,
            onChanged: (value) => vm.gender = value,
            activeColor: AppColors.primary,
          ),
          title: const Text('Other'),
        ),
      ],
    );
  }

  Widget _passwordBody(BuildContext context, RegisterViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        const Text(
          'Choose a Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Create a password with at least 6 characters. It should be something others couldn\'t guess',
          style: TextStyle(
            color: AppColors.dark45,
          ),
        ),
        const SizedBox(height: 30),
        WidgetInput(
            onChanged: (value) => vm.password = value, hint: 'Password'),
        const SizedBox(height: 10),
        WidgetInput(
            onChanged: (value) => vm.passwordConfirm = value,
            hint: 'Confirm Password'),
      ],
    );
  }

  Widget _finishBody(BuildContext context, RegisterViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        const Text(
          'Finish Signing Up',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'By tapping Finish, you agree to receive emails,'
                    ' promotions and general messages from us. In addition, you also agree to our ',
              ),
              TextSpan(
                text: 'Terms & Conditions',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launch(
                      'https://www.ikea.com/us/en/customer-service/terms-conditions/',
                    );
                  },
              ),
              const TextSpan(
                text: ' and ',
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launch(
                      'https://www.ikea.com/us/en/customer-service/terms-conditions/',
                    );
                  },
              ),
              const TextSpan(
                text: '.',
              ),
            ],
            style: const TextStyle(color: AppColors.dark45),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
