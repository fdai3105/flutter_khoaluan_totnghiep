import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class WidgetButton extends StatelessWidget {
  final Function onTap;
  final String text;

  const WidgetButton({Key key, this.onTap, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.radiusNormal,
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text ?? '',
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
