import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';
import '../../presentation.dart';
import '../../../resources/resources.dart';
import '../../../configs/configs.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.backgroundColor,
      child: BaseWidget<HomeViewModel>(
        viewModel: HomeViewModel(
          authRepository: AuthRepository(),
          productResponse: ProductResponse(),
        ),
        onViewModelReady: (vm) async {
          await vm.init();
        },
        builder: (context, vm, child) {
          return _body(context, vm);
        },
      ),
    );
  }

  Widget _body(BuildContext context, HomeViewModel vm) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _appBar(context, vm),
        WidgetIndicator(
          onRefresh: () => vm.init(),
          child: SingleChildScrollView(
            controller: vm.scroll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: AppStyles.paddingBody,
                  child: Text(
                    'Best Furniture\nin your home.',
                    /*style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),*/
                    style: theme.textTheme.headline6,
                  ),
                ),
                const SizedBox(height: 20),
                WidgetInputSearch(
                  hint: 'Search',
                  padding: AppStyles.paddingBody,
                  readOnly: true,
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: SearchScreen(),
                      pageTransitionAnimation: PageTransitionAnimation.slideUp,
                    );
                  },
                ),
                const SizedBox(height: 20),
                const WidgetListHotCategory(),
                const SizedBox(height: 20),
                WidgetListProduct(
                  product: vm.sale,
                  axis: Axis.horizontal,
                  label: 'Hot sale 🔥',
                  padding: AppStyles.paddingBody,
                  seeAll: () => pushNewScreen(
                    context,
                    screen: SaleProductScreen(),
                  ),
                  onTap: (item) {
                    pushNewScreen(
                      context,
                      screen: ProductScreen(id: item.id, name: item.name),
                      withNavBar: false,
                    );
                  },
                ),
                const SizedBox(height: 20),
                WidgetListProduct(
                  product: vm.popular,
                  axis: Axis.horizontal,
                  label: 'Popular',
                  padding: AppStyles.paddingBody,
                  seeAll: () => pushNewScreen(
                    context,
                    screen: PopularProductsScreen(),
                  ),
                  onTap: (item) {
                    pushNewScreen(
                      context,
                      screen: ProductScreen(id: item.id, name: item.name),
                      withNavBar: false,
                    );
                  },
                ),
                const SizedBox(height: 20),
                WidgetListProduct(
                  product: vm.newArrivals,
                  axis: Axis.horizontal,
                  label: 'New Arrivals',
                  padding: AppStyles.paddingBody,
                  seeAll: () => pushNewScreen(
                    context,
                    screen: NewProductsScreen(),
                  ),
                  onTap: (item) {
                    pushNewScreen(
                      context,
                      screen: ProductScreen(id: item.id, name: item.name),
                      withNavBar: false,
                    );
                  },
                ),
                const SizedBox(height: 20),
                WidgetListProduct(
                  product: vm.products,
                  axis: Axis.vertical,
                  label: 'All furniture',
                  showSeeAll: false,
                  padding: AppStyles.paddingBody,
                  loadingMore: vm.loadingMore,
                  seeAll: () {},
                  onTap: (item) {
                    pushNewScreen(
                      context,
                      screen: ProductScreen(id: item.id, name: item.name),
                      withNavBar: false,
                    );
                  },
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _appBar(BuildContext context, HomeViewModel vm) {
    return WidgetAppBar(
      leading: GestureDetector(
        onTap: () => pushNewScreen(
          context,
          screen: vm.user == null ? LoginScreen() : UserScreen(),
          withNavBar: false,
        ),
        child: WidgetAvatar(image: vm.user?.user?.avatar),
      ),
      actions: [
        Badge(
          position: BadgePosition.topEnd(top: 4, end: 4),
          padding: const EdgeInsets.all(6),
          badgeContent: Text(
            vm.countCart().toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.primary,
            ),
            onPressed: () {
              pushNewScreen(
                context,
                screen: CartScreen(),
                withNavBar: false,
              );
            },
          ),
        )
      ],
    );
  }
}
