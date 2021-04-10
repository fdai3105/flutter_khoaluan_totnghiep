import 'package:flutter/material.dart';

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final bool centerTitle;
  final List<Widget> actions;

  const WidgetAppBar({
    Key key,
    this.title,
    this.leading,
    this.centerTitle = true,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: leading,
      centerTitle: centerTitle,
      title: Text(
        title ?? '',
        style: TextStyle(
          color: Colors.grey.shade800,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.grey),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
