import 'package:flutter/material.dart';
import '../../../../configs/configs.dart';
import '../../../../utils/utils.dart';

class OrderSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/cart_done.png',
                height: 300,
              ),
              const SizedBox(height: 40),
              const Text(
                'Thanks you for your order',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We are currently processing your order. You \n can find updates to your order',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.dark45,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('View orders'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
                  style: OutlinedButton.styleFrom(
                    primary: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('Back to home'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
