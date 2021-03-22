import 'package:flutter/material.dart';
import 'src/utils/utils.dart';
import 'src/utils/shared_pref.dart';
import 'src/presentation/presentation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: Routes.routes,
    );
  }
}
