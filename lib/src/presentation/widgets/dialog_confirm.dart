import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DialogConfirm {
  final BuildContext context;
  final Function onConfirm;
  final String title;

  const DialogConfirm({
    this.context,
    this.onConfirm,
    this.title,
  });

  void show() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return _body();
        });
  }

  void hide() => Navigator.pop(context);

  Widget _body() {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: theme.backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            _icon(),
            const SizedBox(height: 20),
            Text(
              title ?? '',
              textAlign: TextAlign.center,
              style: theme.textTheme.headline6,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  hide();
                  onConfirm();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 0,
                ),
                child: Text('delete'.tr),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: hide,
                child: Text('cancel'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: const Icon(
        Icons.clear_outlined,
        color: Colors.red,
        size: 50,
      ),
    );
  }
}
