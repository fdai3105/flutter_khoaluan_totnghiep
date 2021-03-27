import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/configs.dart';
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
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme.apply(
              bodyColor: AppColors.textDark, displayColor: AppColors.textDark),
        ),
      ),
      home: DashboardScreen(),
      routes: Routes.routes,
    );
  }
}
