import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class WidgetTextField extends StatelessWidget {
  final Function(String) onChanged;
  final String hint;
  final String initialValue;
  final EdgeInsets margin;

  const WidgetTextField({
    Key key,
    @required this.onChanged,
    this.hint,
    this.initialValue,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: margin ?? AppStyles.paddingBody,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: AppStyles.radiusNormal,
      ),
      child: TextFormField(
        onChanged: onChanged,
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: hint ?? '',
          hintStyle: const TextStyle(color: AppColors.dark45),
          border: InputBorder.none,
        ),
        cursorColor: AppColors.primary,
      ),
    );
  }
}
