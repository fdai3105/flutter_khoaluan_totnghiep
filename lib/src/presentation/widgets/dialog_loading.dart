import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class DialogLoading {
  BuildContext _context;

  factory DialogLoading.of(BuildContext context) {
    return DialogLoading._create(context);
  }

  DialogLoading._create(this._context);

  BuildContext _builderContext;

  void show() {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) {
          _builderContext = context;
          return _loading();
        });
  }

  void hide() {
    Navigator.pop(_builderContext);
  }

  Widget _loading() {
    return Dialog(
      backgroundColor: Theme.of(_builderContext).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: const [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            SizedBox(width: 20),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
