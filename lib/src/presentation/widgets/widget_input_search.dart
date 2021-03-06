import 'package:flutter/material.dart';

import '../../configs/configs.dart';

class WidgetInputSearch extends StatelessWidget {
  final String hint;
  final EdgeInsets padding;
  final Function(String) onChanged;
  final Function(String) onSubmit;
  final Function onTap;
  final bool readOnly;
  final bool autoFocus;
  final TextEditingController controller;

  const WidgetInputSearch({
    Key key,
    this.hint,
    this.padding,
    this.onTap,
    this.onChanged,
    this.onSubmit,
    this.readOnly = false,
    this.autoFocus = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String input;
    return Padding(
      padding: padding,
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: AppStyles.radiusNormal,
                ),
                child: TextFormField(
                  controller: controller,
                  onTap: onTap,
                  onChanged: (value) {
                    onChanged(value);
                    input = value;
                  },
                  autofocus: autoFocus,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: AppColors.lightModeText),
                  cursorColor: AppColors.tertiary,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onFieldSubmitted: onSubmit,
                  readOnly: readOnly,
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => onSubmit(input),
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: AppStyles.radiusNormal,
                ),
                child: Icon(
                  Icons.search_rounded,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
