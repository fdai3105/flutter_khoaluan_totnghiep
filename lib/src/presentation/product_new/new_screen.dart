// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// Project imports:
import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class NewProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetAppBar(title: 'New arrivals'),
      body: SafeArea(
        child: BaseWidget<NewProductViewModel>(
          viewModel: NewProductViewModel(response: ProductResponse()),
          onViewModelReady: (vm) {
            vm.init();
          },
          builder: (context, vm, widget) {
            return SingleChildScrollView(
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
            );
          },
        ),
      ),
    );
  }
}
