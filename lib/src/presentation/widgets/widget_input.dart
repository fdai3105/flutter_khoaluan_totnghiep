import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class WidgetInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool enableHint;
  final String hint;
  final TextStyle hintStyle;
  final Color color;
  final Color focusColor;
  final BorderRadius borderRadius;
  final Icon prefixIcon;
  final Icon sufferIcon;

  const WidgetInput(
      {Key key,
      this.hint,
      this.enableHint,
      this.color,
      this.focusColor,
      this.borderRadius,
      this.prefixIcon,
      this.sufferIcon,
      this.onChanged,
      this.hintStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: focusColor),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: hint ?? '',
          labelStyle: hintStyle,
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? AppStyles.radiusNormal,
            borderSide: BorderSide(color: color ?? Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? AppStyles.radiusNormal,
            borderSide: BorderSide(color: focusColor ?? Colors.black45),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: sufferIcon,
        ),
      ),
    );
  }
}
