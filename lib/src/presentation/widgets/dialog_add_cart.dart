// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../configs/configs.dart';
import '../../utils/utils.dart';
import '../presentation.dart';

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
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: theme.cardColor,
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
            Text(
              'added_to_cart_success'.tr,
              style: theme.textTheme.bodyText1,
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
                child: Text(
                  'go_to_cart'.tr,
                  style: theme.textTheme.bodyText1,
                ),
              ),
            ),
            WidgetButton(
              onTap: hide,
              text: 'continue_shopping'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
