import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../utils/utils.dart';
import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: const WidgetAppBar(title: 'My Favorites'),
      body: SafeArea(
        child: BaseWidget<FavoriteViewModel>(
          viewModel: FavoriteViewModel(),
          onViewModelReady: (vm) => vm.init(),
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const WidgetLoading();
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
