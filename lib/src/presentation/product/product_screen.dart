import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../../utils/utils.dart';
import '../base/base.dart';
import '../presentation.dart';
import 'product.dart';

class ProductScreen extends StatelessWidget {
  final int id;
  final String name;

  const ProductScreen({
    Key key,
    @required this.id,
    @required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: WidgetAppBar(
        title: name,
        centerTitle: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: CartScreen(),
                );
              }),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: BaseWidget<ProductViewModel>(
          viewModel: ProductViewModel(response: ProductResponse()),
          onViewModelReady: (vm) async {
            await vm.init(id);
          },
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const WidgetLoading();
            } else {
              return Column(
                children: [
                  WidgetIndicator(
                    onRefresh: () => vm.init(id),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetImageCarousel(images: vm.product.data.images),
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              Padding(
                                padding: AppStyles.paddingBody,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                vm.product.data.name,
                                                style:
                                                    theme.textTheme.headline6,
                                              ),
                                              Text(
                                                vm.product.data.sortDesc,
                                                style:
                                                    theme.textTheme.bodyText2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              Formats.money(vm.product.data.price * ((100 - vm.product.data.discount) / 100)),
                                              style: theme.textTheme.bodyText2.copyWith(
                                                fontSize: 12,
                                                decoration: TextDecoration.lineThrough,
                                              ),
                                            ),
                                            Text(
                                              Formats.money(vm.product.data.price),
                                              style: theme.textTheme.bodyText1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        WidgetRatingBar(
                                          stars: vm.product.data.ratingAveraged,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(vm.product.data.ratingAveraged
                                            .toString()),
                                        Container(
                                          width: 1,
                                          height: 14,
                                          color: AppColors.dark.withAlpha(140),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                        Text(
                                            '${'sold'.tr}: ${vm.product.data.bought}'),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              WidgetExpansion(
                                title: 'detail'.tr,
                                children: [Text(vm.product.data.desc ?? '')],
                              ),
                              WidgetTile(
                                title: 'comment'.tr,
                                onTap: () => pushNewScreen(context,
                                    screen: CommentDialog(
                                        productId: vm.product.data.id)),
                              ),
                              WidgetTile(
                                title:
                                    '${'rating'.tr} ${'(${vm.product.data.rating} ${'rating'.tr})'}',
                                onTap: () => pushNewScreen(context,
                                    screen: RatingDialog(
                                        productId: vm.product.data.id)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          WidgetListProduct(
                            onTap: (item) => pushNewScreen(
                              context,
                              screen:
                                  ProductScreen(id: item.id, name: item.name),
                            ),
                            product: vm.similarProducts,
                            label: 'more_like_this'.tr,
                            padding: AppStyles.paddingBody,
                            showSeeAll: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => vm.favorite(),
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: vm.isFavorite
                                  ? AppColors.primary
                                  : Colors.white,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.favorite_outline,
                              color: vm.isFavorite
                                  ? Colors.white
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          fit: FlexFit.tight,
                          child: WidgetButton(
                            onTap: () => vm.addToCart(1, vm.product.data),
                            text: 'add_to_cart'.tr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class WidgetImageCarousel extends StatefulWidget {
  final List<ProductImage> images;

  const WidgetImageCarousel({Key key, this.images}) : super(key: key);

  @override
  _WidgetImageCarouselState createState() => _WidgetImageCarouselState();
}

class _WidgetImageCarouselState extends State<WidgetImageCarousel> {
  CarouselController _carouselController;
  int _current = 1;

  @override
  void initState() {
    _carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.images.isEmpty)
          Image.asset(
            'assets/images/placeholder.jpg',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          )
        else
          CarouselSlider(
            carouselController: _carouselController,
            items: widget.images.map((e) {
              return CachedNetworkImage(
                imageUrl: AppEndpoint.domain + e.image,
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Image.asset(
                    'assets/images/placeholder.jpg',
                    fit: BoxFit.cover,
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                height: 420,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index + 1;
                  });
                }),
          ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            margin: const EdgeInsets.only(bottom: 20, right: 10),
            decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10)),
            child: widget.images.isEmpty
                ? const Text('0/0')
                : Text(
                    '$_current/${widget.images.length}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Colors.white),
                  ),
          ),
        ),
      ],
    );
  }
}
