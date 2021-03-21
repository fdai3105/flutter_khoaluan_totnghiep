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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _appbar(vm),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Best Furniture\nin your home.',
                  style: TextStyle(
                    color: AppColors.textDark.withOpacity(0.7),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _search(context, vm),
                const SizedBox(height: 20),
                WidgetListProduct(
                  product: vm.popular,
                  isVertical: false,
                  label: 'Popular',
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
    );
  }

  Widget _search(BuildContext context, HomeViewModel vm) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: AppStyles.radiusNormal,
              ),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: const Icon(Icons.search_rounded),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: AppStyles.radiusNormal,
            ),
            child: Icon(
              Icons.search_rounded,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
