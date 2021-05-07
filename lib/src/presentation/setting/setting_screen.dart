import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/configs.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../main_viewmodel.dart';
import '../../utils/shared_pref.dart';
import '../presentation.dart';
import 'lang/lang_screen.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mainVM = Provider.of<MainViewModel>(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: WidgetAppBar(title: 'setting'.tr),
      body: Column(
        children: [
          SwitchListTile(
            onChanged: (value) => mainVM.darkMode = value,
            value: mainVM.darkMode,
            title: Text('dark_mode'.tr, style: theme.textTheme.bodyText1),
          ),
          ListTile(
            onTap: () => pushNewScreen(context, screen: LanguageScreen()),
            title: Text('language'.tr, style: theme.textTheme.bodyText1),
            trailing: Text(
              mainVM.language == AppTranslations.en
                  ? 'english'.tr
                  : 'vietnamese'.tr,
              style: theme.textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
