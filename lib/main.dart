import 'package:flutter/material.dart';
import 'src/utils/utils.dart';
import 'src/utils/shared_pref.dart';
import 'src/presentation/presentation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginScreen(),
      routes: Routes.routes,
    );
  }
}
