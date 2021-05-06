import 'package:flutter/material.dart';

import '../../../configs/configs.dart';
import '../../../resources/resources.dart';
import '../../../utils/shared_pref.dart';
import '../../presentation.dart';

class ResendMailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: const WidgetAppBar(
        title: 'Verify your email ',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/verify_email.png'),
              const SizedBox(height: 20),
              const Text(
                'Verify your email',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: theme.textTheme.bodyText1,
                  children: [
                    const TextSpan(text: 'You\'ve entered '),
                    TextSpan(
                      text: SharedPref.getUser().user.email,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' as the email address for your account. Please verify this email addres by click button below',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              WidgetButton(onTap: () => verify(context), text: 'Send'),
            ],
          ),
        ),
      ),
    );
  }

  Future verify(BuildContext context) async {
    final ld = DialogLoading.of(context)..show();
    final rp = await AuthRepository().sendVerifyMail();
    ld.hide();

    if (rp.statusCode == 200) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something error, please try again')));
    }
  }
}
