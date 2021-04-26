import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/utils/utils.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../configs/configs.dart';
import '../../utils/formats.dart';
import '../presentation.dart';
import '../../resources/resources.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: WidgetAppBar(
          title: 'My order',
          bottom: TabBar(
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
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
                return WidgetLoading();
              } else {
                return TabBarView(
                  children: [
                    _page(context, vm.orders),
                    _page(context, vm.pendingOrders),
                    _page(context, vm.completedOrders),
                    _page(context, vm.cancelledOrders),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _page(BuildContext context, Order order) {
    if (order.data.isEmpty) {
      return const Center(child: Text('No orders yet'));
    }
    return ListView.separated(
      padding: const EdgeInsets.only(top: 10),
      itemCount: order.data.length,
      itemBuilder: (context, index) {
        final item = order.data[index];
        return ListTile(
          onTap: () => pushNewScreen(
            context,
            screen: OrderDetailScreen(order: item),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                    color: statusColor(item.status), borderRadius: BorderRadius.circular(10)),
                child: Text(
                  '#${item.id}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Text('${item.item} items'),
              Text('Total: ${Formats.money(item.total)}'),
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
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
