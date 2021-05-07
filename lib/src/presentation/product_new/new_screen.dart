import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:get/get.dart';
import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class NewProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: WidgetAppBar(title: 'new_arrivals'.tr),
      body: SafeArea(
        child: BaseWidget<NewProductViewModel>(
          viewModel: NewProductViewModel(response: ProductResponse()),
          onViewModelReady: (vm) {
            vm.init();
          },
          builder: (context, vm, widget) {
            return WidgetIndicator(
              expanded: false,
              onRefresh: () => vm.init(),
              child: SingleChildScrollView(
                controller: vm.scroll,
                child: WidgetListProduct(
                  onTap: (item) => pushNewScreen(
                    context,
                    screen: ProductScreen(id: item.id, name: item.name),
                    withNavBar: false,
                  ),
                  product: vm.products,
                  loadingMore: vm.loadingMore,
                  showSeeAll: false,
                  axis: Axis.vertical,
                  padding: AppStyles.paddingBody,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
