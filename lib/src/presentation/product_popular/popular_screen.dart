import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/configs.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/product_popular/popular.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/repositories/product.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
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
                  screen: ProductScreen(id: item.id),
                  withNavBar: false,
                ),
                product: vm.products,
                loadingMore: vm.loadingMore,
                isVertical: true,
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
