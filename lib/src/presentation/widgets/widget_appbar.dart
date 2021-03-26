import 'package:flutter/material.dart';

class WidgetAppbar extends StatelessWidget {
  final String title;
  final Widget leading;
  final List<Widget> actions;

  const WidgetAppbar({
    Key key,
    this.title = '',
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade800,
        ),
      ),
      leading: leading,
      actions: actions,
    );
  }
}
