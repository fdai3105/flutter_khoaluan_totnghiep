import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Best Furnitute\nin your home.',
                style: TextStyle(
                  color: AppColors.textDark.withOpacity(0.7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _search(context, vm),
              const SizedBox(height: 20),
              _ListHorizon(
                product: vm.popular,
                label: 'Popular',
              ),
              const SizedBox(height: 20),
              _ListHorizon(
                product: vm.newArrivals,
                label: 'New Arrivals',
                onTap: (item) {
                  print(item.id);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
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

class _ListHorizon extends StatelessWidget {
  final ProductPagination product;
  final String label;
  final Function seeAll;
  final Function(Product) onTap;

  const _ListHorizon({
    Key key,
    this.product,
    this.label,
    this.seeAll,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(),
        if (product == null) _bodyShimmer(context) else _body(context),
      ],
    );
  }

  Widget _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label ?? '',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () => seeAll,
          child: const Text(
            'See all',
            style: TextStyle(
              color: AppColors.hintDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  Widget _imageItem(List<ProductImage> images) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(6),
      ),
      child: images.isEmpty
          ? Image.asset(
              'assets/images/placeholder.jpg',
              width: 150,
              height: 120,
              fit: BoxFit.fill,
            )
          : Image.network(
              AppEndpoint.domain + images.first.image,
              width: 150,
              height: 120,
              fit: BoxFit.cover,
            ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: product.data.length,
        itemBuilder: (context, index) {
          final item = product.data[index];
          return GestureDetector(
            onTap: () => onTap(item),
            child: Container(
              width: 150,
              margin: EdgeInsets.only(
                left: index == 0 ? 0 : 10,
                right: 10,
                bottom: 10,
                top: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _imageItem(item.images),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('${item.price} vnd'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bodyShimmer(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : 10,
              right: 10,
              bottom: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _imageItem([]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            color: Colors.grey,
                            height: 10,
                            width: double.infinity),
                        const SizedBox(height: 4),
                        Container(color: Colors.grey, height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
