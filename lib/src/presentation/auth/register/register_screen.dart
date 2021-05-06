import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../configs/configs.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar:  WidgetAppBar(title: 'register'.tr),
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
                      children: bodies(context, vm),
                    ),
                  ),
                  WidgetButton(
                    onTap: () => vm.nextPage(),
                    text: vm.pageIndex + 1 == bodies(context, vm).length
                        ? 'finish'.tr
                        : 'next'.tr,
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
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        Text('register_name_title'.tr, style: theme.textTheme.bodyText1),
        const SizedBox(height: 10),
        Text(
          'register_name_desc'.tr,
          style: theme.textTheme.subtitle1,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Flexible(
              child: WidgetInput(
                onChanged: (value) {
                  vm.name = value;
                },
                hint: 'register_first_name'.tr,
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: WidgetInput(
                onChanged: (value) {
                  vm.name += value;
                },
                hint: 'register_last_name'.tr,
              ),
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
        Text(
          'register_email_title'.tr,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'register_email_desc'.tr,
          style: const TextStyle(
            color: AppColors.dark45,
          ),
        ),
        const SizedBox(height: 30),
        WidgetInput(onChanged: (value) => vm.email = value, hint: 'email'.tr),
      ],
    );
  }

  Widget _phoneBody(BuildContext context, RegisterViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        Text(
          'register_phone_title'.tr,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'register_phone_desc'.tr,
          style: const TextStyle(
            color: AppColors.dark45,
          ),
        ),
        const SizedBox(height: 30),
        WidgetInput(
            onChanged: (value) => vm.phone = value, hint: 'register_phone'.tr),
      ],
    );
  }

  Widget _genderBody(BuildContext context, RegisterViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        Text(
          'register_gender_title'.tr,
          style: const TextStyle(
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
          title: Text('register_gender_male'.tr),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Radio(
            value: 2,
            groupValue: vm.gender,
            onChanged: (value) => vm.gender = value,
            activeColor: AppColors.primary,
          ),
          title: Text('register_gender_female'.tr),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Radio(
            value: 9,
            groupValue: vm.gender,
            onChanged: (value) => vm.gender = value,
            activeColor: AppColors.primary,
          ),
          title: Text('register_gender_other'.tr),
        ),
      ],
    );
  }

  Widget _passwordBody(BuildContext context, RegisterViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        Text(
          'register_password_title'.tr,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'register_password_desc'.tr,
          style: const TextStyle(
            color: AppColors.dark45,
          ),
        ),
        const SizedBox(height: 30),
        WidgetInput(
            onChanged: (value) => vm.password = value, hint: 'password'.tr),
        const SizedBox(height: 10),
        WidgetInput(
          onChanged: (value) => vm.passwordConfirm = value,
          hint: 'confirm_password'.tr,
        ),
      ],
    );
  }

  Widget _finishBody(BuildContext context, RegisterViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        Text(
          'register_finish_title'.tr,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'register_finish_desc'.tr),
              TextSpan(
                text: 'register_finish_desc1'.tr,
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
              TextSpan(text: 'register_finish_desc2'.tr),
              TextSpan(
                text: 'register_finish_desc3'.tr,
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
