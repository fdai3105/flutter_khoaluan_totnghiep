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
  final String value;
  final bool readOnly;

  const WidgetInput({
    Key key,
    this.hint,
    this.enableHint,
    this.color,
    this.focusColor,
    this.borderRadius,
    this.prefixIcon,
    this.sufferIcon,
    this.onChanged,
    this.hintStyle,
    this.value,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(primaryColor: focusColor ?? AppColors.dark45),
      child: TextFormField(
        onChanged: onChanged,
        initialValue: value ?? '',
        decoration: InputDecoration(
          labelText: hint ?? '',
          labelStyle: hintStyle == null
              ? hintStyle
              : hintStyle.copyWith(color: AppColors.dark45),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? AppStyles.radiusNormal,
            borderSide: BorderSide(color: color ?? AppColors.dark45),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? AppStyles.radiusNormal,
            borderSide: BorderSide(color: focusColor ?? AppColors.dark45),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: sufferIcon,
        ),
        readOnly: readOnly,
        validator: (value) {
          if (value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }
}
