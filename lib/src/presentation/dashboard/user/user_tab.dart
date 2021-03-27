import 'package:flutter/material.dart';
import '../../presentation.dart';

class UserTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: const [
          WidgetAppbar(
            title: 'User',
          ),
        ],
      ),
    );
  }
}
