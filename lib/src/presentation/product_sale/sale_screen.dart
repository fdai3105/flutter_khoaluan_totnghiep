import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/configs.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/repositories/product.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
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
            print(vm.products);
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
                isVertical: true,
                padding: AppStyles.paddingBody,
              ),
            );
          },
        ),
      ),
    );
  }
}
