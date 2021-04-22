import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class SaleProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetAppBar(title: 'Hot sale'),
      body: SafeArea(
        child: BaseWidget<SaleViewModel>(
          viewModel: SaleViewModel(response: ProductResponse()),
          onViewModelReady: (vm) {
            vm.init();
          },
          builder: (context, vm, widget) {
            return SingleChildScrollView(
              controller: vm.scroll,
              child: WidgetListProduct(
                onTap: (item) => pushNewScreen(
                  context,
                  screen: ProductScreen(id: item.id),
                  withNavBar: false,
                ),
                product: vm.products,
                showSeeAll: false,
                axis: Axis.vertical,
                loadingMore: vm.loadingMore,
                padding: AppStyles.paddingBody,
              ),
            );
          },
        ),
      ),
    );
  }
}
