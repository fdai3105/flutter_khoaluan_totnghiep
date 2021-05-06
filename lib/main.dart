import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:khoaluan_totnghiep_mobile/main_viewmodel.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/configs.dart';
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
    return BaseWidget<MainViewModel>(
      viewModel: MainViewModel(),
      onViewModelReady: (vm) => vm.init(),
      builder: (context, vm, widget) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: DashboardScreen(),
          initialRoute: Routes.home,
          routes: Routes.routes,
          themeMode: vm.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppStyles.lightMode(),
          darkTheme: AppStyles.darkMode(context),
        );
      },
    );
  }
}
