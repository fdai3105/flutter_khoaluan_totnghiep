import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetTile extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData icon;

  const WidgetTile({
    Key key,
    this.title = '',
    this.onTap,
    this.icon = Icons.arrow_forward_ios_outlined,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title ?? '',
        style: GoogleFonts.inter(
          fontSize: 14,
        ),
      ),
      trailing: Icon(
        icon,
        size: 14,
      ),
    );
  }
}