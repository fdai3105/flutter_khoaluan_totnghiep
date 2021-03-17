import 'package:flutter/material.dart';
import 'src/presentation/presentation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: RegisterScreen(),
    );
  }
}
