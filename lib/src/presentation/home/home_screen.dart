import 'package:flutter/material.dart';
import '../../resources/resources.dart';
import '../presentation.dart';
import '../../configs/constants/constants.dart';
import '../../configs/configs.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
      ),
    );
  }

  Widget _mobile(BuildContext context, HomeViewModel vm) {
    const paddingBody = EdgeInsets.symmetric(horizontal: 10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _appbar(vm),
        Expanded(
          child: SingleChildScrollView(
            controller: vm.scroll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: paddingBody,
                  child: Text(
                    'Best Furniture\nin your home.',
                    style: TextStyle(
                      color: AppColors.textDark.withOpacity(0.7),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                WidgetInputSearch(
                  hint: 'Search',
                  padding: paddingBody,
                  onSubmit: (value) {
                    print(value);
                  },
                ),
                const SizedBox(height: 20),
                WidgetListProduct(
                  product: vm.popular,
                  isVertical: false,
                  label: 'Popular',
                  padding: paddingBody,
                  seeAll: () {},
                  onTap: (item) {
                    print(item.name);
                  },
                ),
                const SizedBox(height: 20),
                WidgetListProduct(
                  product: vm.newArrivals,
                  isVertical: false,
                  label: 'New Arrivals',
                  padding: paddingBody,
                  seeAll: () {},
                  onTap: (item) {
                    print(item.name);
                  },
                ),
                const SizedBox(height: 20),
                WidgetListProduct(
                  product: vm.products,
                  isVertical: true,
                  label: 'All furniture',
                  padding: paddingBody,
                  loadingMore: vm.loadingMore,
                  seeAll: () {},
                  onTap: (item) {
                    print(item.name);
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

  Widget _appbar(HomeViewModel vm) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: vm.user == null
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset('assets/images/placeholder.jpg'),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    vm.user.user.avatar ?? 'assets/images/placeholder.jpg',
                  ),
                ),
              ),
            ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.primary,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
