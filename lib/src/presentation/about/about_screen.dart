import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../presentation.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: WidgetAppBar(title: 'about'.tr),
      body: Container(),
    );
  }
}
