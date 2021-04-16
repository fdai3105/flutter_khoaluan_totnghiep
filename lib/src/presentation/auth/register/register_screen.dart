import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';
import '../../widgets/widgets.dart';
import '../../../configs/configs.dart';

class RegisterScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      physics: const NeverScrollableScrollPhysics(),
                      controller: vm.pageController,
                      onPageChanged: (index) {
                        vm.pageIndex = index;
                      },
                      children: bodies(context, vm),
                    ),
                  ),
                  WidgetButton(
                    onTap: () => vm.nextPage(),
                    text: 'Next',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
            // return _mobile(context, vm);
          },
        ),
      ),
    );
  }

  Widget _namedBody(BuildContext context, RegisterViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        const Text(
          'What\'t your name?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Enter the name you use in real life.',
          style: TextStyle(
            color: AppColors.dark45,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            WidgetTextField2(
              onChanged: (value) {
                vm.name = value;
              },
              hint: 'First name',
            ),
            const SizedBox(width: 20),
            WidgetTextField2(
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
        WidgetTextField2(onChanged: (value) => vm.email = value, hint: 'Email'),
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
        WidgetTextField2(
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
              onChanged: (value) => vm.gender = value),
          title: const Text('Male'),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Radio(
              value: 2,
              groupValue: vm.gender,
              onChanged: (value) => vm.gender = value),
          title: const Text('Female'),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Radio(
              value: 9,
              groupValue: vm.gender,
              onChanged: (value) => vm.gender = value),
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
        WidgetTextField2(
            onChanged: (value) => vm.password = value, hint: 'Password'),
        const SizedBox(height: 10),
        WidgetTextField2(
            onChanged: (value) => vm.passwordConfirm = value,
            hint: 'Confirm Password'),
      ],
    );
  }

  Widget _finishBody(BuildContext context, RegisterViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
         SizedBox(height: 60),
         Text(
          'Finish Signing Up',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
         SizedBox(height: 10),
         Text(
          'By tapping Sign Up, you agree to our Terms, Date Policy.',
          style: TextStyle(
            color: AppColors.dark45,
          ),
        ),
         SizedBox(height: 30),
      ],
    );
  }
}

class WidgetTextField2 extends StatelessWidget {
  final String hint;
  final Function(String) onChanged;

  const WidgetTextField2({
    Key key,
    this.hint,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: AppStyles.radiusNormal,
        ),
        child: TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint ?? '',
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 14,
            ),
            isDense: true,
            enabledBorder: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: AppStyles.radiusNormal,
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
