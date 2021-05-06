import 'package:flutter/material.dart';

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final bool centerTitle;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;

  const WidgetAppBar({
    Key key,
    this.title,
    this.leading,
    this.centerTitle = true,
    this.actions,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.backgroundColor,
      elevation: 0,
      leading: leading,
      centerTitle: centerTitle,
      title: Text(
        title ?? '',
        style: theme.textTheme.headline6.copyWith(color: theme.iconTheme.color),
      ),
      iconTheme: theme.iconTheme,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0));
}
