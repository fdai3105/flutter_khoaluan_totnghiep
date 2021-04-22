import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class WidgetLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }
}
