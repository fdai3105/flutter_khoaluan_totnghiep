import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Text(SharedPref.getUser().user.name),
      ),
    );
  }
}
