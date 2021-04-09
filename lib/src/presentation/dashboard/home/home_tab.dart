import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/routers.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../presentation.dart';
import '../../../resources/resources.dart';
import '../../../configs/configs.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BaseWidget<HomeViewModel>(
        viewModel: HomeViewModel(
          authRepository: AuthRepository(),
          productResponse: ProductResponse(),
        ),
        onViewModelReady: (vm) async {
          await vm.init();
        },
        builder: (context, vm, child) {
          return _mobile(context, vm);
        },
      ),
    );
  }

  Widget _mobile(BuildContext context, HomeViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _appBar(context, vm.user),
        Expanded(
          child: GlowingOverscrollIndicator(
            color: Colors.white,
            axisDirection: AxisDirection.down,
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
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideUp,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  WidgetListProduct(
                    product: vm.popular,
                    isVertical: false,
                    label: 'Popular',
                    padding: AppStyles.paddingBody,
                    seeAll: () {},
                    onTap: (item) {
                      pushNewScreen(
                        context,
                        screen: ProductScreen(id: item.id),
                        withNavBar: false,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  WidgetListProduct(
                    product: vm.newArrivals,
                    isVertical: false,
                    label: 'New Arrivals',
                    padding: AppStyles.paddingBody,
                    seeAll: () {},
                    onTap: (item) {
                      pushNewScreen(
                        context,
                        screen: ProductScreen(id: item.id),
                        withNavBar: false,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  WidgetListProduct(
                    product: vm.products,
                    isVertical: true,
                    label: 'All furniture',
                    padding: AppStyles.paddingBody,
                    loadingMore: vm.loadingMore,
                    seeAll: () {},
                    onTap: (item) {
                      pushNewScreen(
                        context,
                        screen: ProductScreen(id: item.id),
                        withNavBar: false,
                      );
                    },
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _appBar(BuildContext context, User user) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.grey),
      leading: _avatar(context, user),
      actions: [
        IconButton(
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
        )
      ],
    );
  }

  Widget _avatar(BuildContext context, User user) {
    if (user != null) {
      if (user.user.avatar != null) {
        return GestureDetector(
          onTap: () => pushNewScreen(
            context,
            screen: UserScreen(),
            withNavBar: false,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipOval(
              child: Image.network(
                AppEndpoint.domain + user.user.avatar,
              ),
            ),
          ),
        );
      }
    }
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.login),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipOval(
          child: Image.asset('assets/images/placeholder.jpg'),
        ),
      ),
    );
  }
}
