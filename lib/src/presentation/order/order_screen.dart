import 'package:flutter/material.dart';
import '../base/base.dart';
import 'order.dart';
import '../../resources/repositories/order.dart';
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
          viewModel: OrderViewModel(repository: OrderRepository()),
          onViewModelReady: (vm) => vm.init(),
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: vm.orders.data.length,
                itemBuilder: (context, index) {
                  final item = vm.orders.data[index];
                  return ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('#' + item.id.toString()),
                        Text(item.total.toString()),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
