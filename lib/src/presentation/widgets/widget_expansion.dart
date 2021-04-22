import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class WidgetExpansion extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const WidgetExpansion({
    Key key,
    this.title,
    @required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(accentColor: AppColors.primary,dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(color: AppColors.dark),
        ),
        childrenPadding: const EdgeInsets.all(10),
        children: children,
      ),
    );
  }
}
