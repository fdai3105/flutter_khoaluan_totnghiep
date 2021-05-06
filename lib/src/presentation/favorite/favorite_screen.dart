import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: WidgetAppBar(title: 'favorite'.tr),
      body: SafeArea(
        child: BaseWidget<FavoriteViewModel>(
          viewModel: FavoriteViewModel(),
          onViewModelReady: (vm) => vm.init(),
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const WidgetLoading();
            }
            if (vm.favorites.isEmpty) {
              return Center(
                child: Text('nothing_to_show'.tr),
              );
            }

            return WidgetListProduct(
              product: Products(data: vm.favorites),
              onTap: (item) => pushNewScreen(
                context,
                screen: ProductScreen(id: item.id, name: item.name),
              ).then((value) => vm.init()),
              axis: Axis.vertical,
              showSeeAll: false,
              padding: AppStyles.paddingBody,
            );
          },
        ),
      ),
    );
  }
}
