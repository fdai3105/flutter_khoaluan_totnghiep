import 'package:flutter/material.dart';
import '../../../main_viewmodel.dart';
import 'package:provider/provider.dart';
import '../presentation.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainVM = Provider.of<MainViewModel>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const WidgetAppBar(title: 'Setting'),
      body: Column(
        children: [
          SwitchListTile(
            onChanged: (value) => mainVM.darkMode = value,
            value: mainVM.darkMode,
            title: const Text('Dark mode'),
          ),
        ],
      ),
    );
  }
}
