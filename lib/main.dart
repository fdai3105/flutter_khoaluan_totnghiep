// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';

// Project imports:
import 'main_viewmodel.dart';
import 'src/configs/configs.dart';
import 'src/presentation/presentation.dart';
import 'src/utils/utils.dart';

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
        return GetMaterialApp(
          translations: AppTranslations(),
          locale: AppTranslations.getLocale(vm.language) ?? Get.deviceLocale,
          fallbackLocale: const Locale('vi', 'VN'),
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
