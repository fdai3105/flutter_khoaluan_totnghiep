// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../configs/configs.dart';

class WidgetIndicator extends StatelessWidget {
  final Widget child;
  final Function onRefresh;
  final bool expanded;

  const WidgetIndicator({
    Key key,
    this.child,
    this.onRefresh,
    this.expanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return expanded ? Expanded(child: _child()) : _child();
  }

  Widget _child() {
    return GlowingOverscrollIndicator(
      color: Colors.grey,
      axisDirection: AxisDirection.down,
      child: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => await onRefresh(),
        child: child,
      ),
    );
  }
}
