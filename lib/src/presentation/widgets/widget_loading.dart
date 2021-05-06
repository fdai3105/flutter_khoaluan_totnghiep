// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../configs/configs.dart';

class WidgetLoading extends StatelessWidget {
  final double progress;

  const WidgetLoading({Key key, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        value: progress,
      ),
    );
  }
}
