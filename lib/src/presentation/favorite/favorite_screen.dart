import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/configs.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/favorite/favorite.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/presentation.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/models/models.dart';
import 'package:khoaluan_totnghiep_mobile/src/utils/routers.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../base/base.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetAppBar(title: 'My Favorites'),
      body: SafeArea(
        child: BaseWidget<FavoriteViewModel>(
          viewModel: FavoriteViewModel(),
          onViewModelReady: (vm) => vm.init(),
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return WidgetLoading();
            }
            if (vm.favorites.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Nothing to show'),
                      const SizedBox(height: 20),
                      WidgetButton(
                        text: 'Continue shopping',
                        onTap: () => Navigator.pushReplacementNamed(
                          context,
                          Routes.home,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return WidgetListProduct(
              product: Products(data: vm.favorites),
              onTap: (item) => pushNewScreen(
                context,
                screen: ProductScreen(id: item.id),
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
