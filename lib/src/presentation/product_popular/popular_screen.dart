import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class PopularProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetAppBar(title: 'Popular'),
      body: SafeArea(
        child: BaseWidget<PopularViewModel>(
          viewModel: PopularViewModel(response: ProductResponse()),
          onViewModelReady: (vm) {
            vm.init();
          },
          builder: (context, vm, widget) {
            return SingleChildScrollView(
              controller: vm.scroll,
              child: WidgetListProduct(
                onTap: (item) => pushNewScreen(
                  context,
                  screen: ProductScreen(id: item.id,name: item.name),
                  withNavBar: false,
                ),
                product: vm.products,
                loadingMore: vm.loadingMore,
                axis: Axis.vertical,
                showSeeAll: false,
                padding: AppStyles.paddingBody,
              ),
            );
          },
        ),
      ),
    );
  }
}
