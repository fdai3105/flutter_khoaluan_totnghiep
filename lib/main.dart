import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/configs/configs.dart';
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
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme.apply(
              bodyColor: AppColors.dark, displayColor: AppColors.dark),
        ),
      ),
      home: DashboardScreen(),
      routes: Routes.routes,
    );
  }
}
