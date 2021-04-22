import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'src/utils/utils.dart';
import 'src/presentation/presentation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.getInstance();

  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
      initialRoute: Routes.home,
      routes: Routes.routes,
    );
  }
}
