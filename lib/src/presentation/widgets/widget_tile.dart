import 'package:flutter/material.dart';

class WidgetTile extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData icon;

  const WidgetTile({
    Key key,
    this.title = '',
    this.onTap,
    this.icon = Icons.chevron_right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title ?? '',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: Icon(
        icon,
      ),
    );
  }
}
