// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../configs/configs.dart';

class WidgetInput extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;
  final String hint;
  final String value;
  final bool readOnly;
  final EdgeInsets margin;

  const WidgetInput({
    Key key,
    this.hint,
    this.onChanged,
    this.controller,
    this.value,
    this.readOnly = false,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: AppStyles.radiusNormal,
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        initialValue: value,
        readOnly: readOnly,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: AppColors.lightModeText),
        cursorColor: AppColors.tertiary,
        decoration: InputDecoration(
          hintText: hint ?? '',
          hintStyle: TextStyle(color: theme.hintColor),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 14,
          ),
          isDense: true,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: AppStyles.radiusNormal,
            borderSide: const BorderSide(
              color: AppColors.tertiary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

// class WidgetInput extends StatelessWidget {
//   final ValueChanged<String> onChanged;
//   final bool enableHint;
//   final String hint;
//   final TextStyle hintStyle;
//   final Color color;
//   final Color focusColor;
//   final BorderRadius borderRadius;
//   final Icon prefixIcon;
//   final Icon sufferIcon;
//   final String value;
//   final bool readOnly;
//   final TextInputType type;
//   final bool isPassword;
//
//   const WidgetInput({
//     Key key,
//     this.hint,
//     this.enableHint,
//     this.color,
//     this.focusColor,
//     this.borderRadius,
//     this.prefixIcon,
//     this.sufferIcon,
//     this.onChanged,
//     this.hintStyle,
//     this.value,
//     this.readOnly = false,
//     this.type,
//     this.isPassword = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context)
//           .copyWith(primaryColor: focusColor ?? AppColors.dark45),
//       child: TextFormField(
//         onChanged: onChanged,
//         initialValue: value ?? '',
//         keyboardType: type,
//         decoration: InputDecoration(
//           labelText: hint ?? '',
//           labelStyle: hintStyle == null
//               ? hintStyle
//               : hintStyle.copyWith(color: AppColors.dark45),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: borderRadius ?? AppStyles.radiusNormal,
//             borderSide: BorderSide(color: color ?? AppColors.dark45),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: borderRadius ?? AppStyles.radiusNormal,
//             borderSide: BorderSide(color: focusColor ?? AppColors.dark45),
//           ),
//           prefixIcon: prefixIcon,
//           suffixIcon: sufferIcon,
//         ),
//         readOnly: readOnly,
//         obscureText: isPassword,
//       ),
//     );
//   }
// }
