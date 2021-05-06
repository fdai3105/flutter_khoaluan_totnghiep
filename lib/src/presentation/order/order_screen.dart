// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// Project imports:
import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../../utils/formats.dart';
import '../../utils/utils.dart';
import '../presentation.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: WidgetAppBar(
          title: 'order'.tr,
          bottom: TabBar(
            tabs: [
              Tab(text: 'all'.tr),
              Tab(text: 'pending'.tr),
              Tab(text: 'shipping'.tr),
              Tab(text: 'completed'.tr),
              Tab(text: 'cancelled'.tr),
            ],
            isScrollable: true,
            labelColor: theme.textTheme.bodyText1.color,
            indicatorColor: AppColors.primary,
          ),
        ),
        body: SafeArea(
          child: BaseWidget<OrderViewModel>(
            viewModel: OrderViewModel(repository: OrderRepository()),
            onViewModelReady: (vm) => vm.init(),
            builder: (context, vm, widget) {
              if (vm.isLoading) {
                return const WidgetLoading();
              } else {
                return TabBarView(
                  children: [
                    _page(context, vm.orders),
                    _page(context, vm.pendingOrders),
                    _page(context, vm.shippingOrders),
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
      return Center(child: Text('nothing_to_show'.tr));
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
                    color: statusColor(item.status),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  '#${item.id}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 4),
              Text('${item.item} ${'items'.tr}'),
              Text('${'total'.tr}: ${Formats.money(item.total)}'),
              Row(
                children: [
                  Text('${'order_time'.tr}: '),
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
