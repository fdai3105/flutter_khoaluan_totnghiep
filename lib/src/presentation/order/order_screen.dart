import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/constants/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../utils/formats.dart';
import '../presentation.dart';
import '../../resources/resources.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:  WidgetAppBar(
          title: 'My order',
          bottom: TabBar(
            tabs:  const [
              Tab(text: 'All'),
              Tab(text: 'Pending'),
              Tab(text: 'To Receive'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
            isScrollable: true,
            unselectedLabelColor: AppColors.dark45,
            labelColor: AppColors.dark,
            indicatorColor: AppColors.primary,
          ),
        ),
        body: SafeArea(
          child: BaseWidget<OrderViewModel>(
            viewModel: OrderViewModel(repository: OrderRepository()),
            onViewModelReady: (vm) => vm.init(),
            builder: (context, vm, widget) {
              if (vm.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return TabBarView(
                  children: [
                    _listView(context, vm.orders),
                    _listView(context, vm.pendingOrders),
                    _listView(context, vm.toReceiveOrders),
                    _listView(context, vm.completedOrders),
                    _listView(context, vm.cancelledOrders),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _listView(BuildContext context, Order order) {
    if(order.data.isEmpty) {
      return const Center(child: Text('No orders yet'));
    }
    return ListView.builder(
      itemCount: order.data.length,
      itemBuilder: (context, index) {
        final item = order.data[index];
        return ListTile(
          onTap: () => pushNewScreen(
            context,
            screen: OrderDetailScreen(id: item.id),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('#${item.id}'),
              Text('${item.item} items'),
              Text(Formats.money(item.total)),
              Row(
                children: [
                  const Text('Order time: '),
                  Text(Formats.dateTime(item.createdAt)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
