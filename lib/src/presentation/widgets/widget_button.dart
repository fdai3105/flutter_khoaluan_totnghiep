// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../configs/configs.dart';

class WidgetButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final EdgeInsets margin;
  final MaterialColor color;

  const WidgetButton({
    Key key,
    @required this.onTap,
    @required this.text,
    this.margin,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin ??
          const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: color ?? AppColors.primary,
          primary: color?.shade200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Text(
            text ?? '',
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
