import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget child)
      builder;
  final T viewModel;
  final Widget child;
  final Function(T viewModel) onViewModelReady;

  const BaseWidget(
      {Key key,
      this.builder,
      this.viewModel,
      this.onViewModelReady,
      this.child})
      : super(key: key);

  @override
  _BaseWidgetState createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> {
  @override
  void initState() {
    if (widget.onViewModelReady != null) {
      widget.onViewModelReady(widget.viewModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => widget.viewModel..context = context,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
    return Container();
  }
}
