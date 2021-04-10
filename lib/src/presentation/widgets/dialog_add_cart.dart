import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../../configs/configs.dart';

class DialogAddCart {
  final BuildContext context;

  DialogAddCart({this.context});

  void show() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return _loading();
        });
  }

  void hide() => Navigator.pop(context);

  Widget _loading() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green),
              ),
              child: const Icon(
                Icons.check_outlined,
                color: Colors.green,
                size: 50,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Added to cart success',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  hide();
                  Navigator.pushNamed(context, Routes.cart);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                ),
                child: const Text(
                  'Go to cart',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: hide,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary.withOpacity(0.4)),
                ),
                child: Text(
                  'Continue shopping',
                  style: TextStyle(color: AppColors.dark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
