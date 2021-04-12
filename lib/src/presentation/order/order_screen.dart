import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/base/base.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/order/order.dart';
import '../widgets/widgets.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetAppBar(
        title: 'My order',
      ),
      body: SafeArea(
        child: BaseWidget<OrderViewModel>(
          viewModel: OrderViewModel(),
          onViewModelReady: (vm) => vm.init(),
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                // itemCount: ,
                itemBuilder: (context, index) {},
              );
            }
          },
        ),
      ),
    );
  }
}
