import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/utils.dart';
import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class WidgetListProduct extends StatelessWidget {
  final Products product;
  final String label;
  final EdgeInsets padding;
  final Function seeAll;
  final Function(ProductDatum) onTap;
  final Axis axis;
  final bool verticalShrinkWrap;
  final bool loadingMore;
  final bool showSeeAll;

  const WidgetListProduct({
    Key key,
    @required this.product,
    @required this.onTap,
    this.label,
    this.padding = const EdgeInsets.all(0),
    this.seeAll,
    this.axis = Axis.horizontal,
    this.loadingMore = false,
    this.showSeeAll = true,
    this.verticalShrinkWrap = true,
  }) : super(key: key);

  static const double horizonWidth = 124;
  static const double horizonHeight = 200;
  static const double verticalRatio = 0.85;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label == null && !showSeeAll) const SizedBox() else _title(context),
        if (axis == Axis.vertical) _vertical(context) else _horizon(context),
      ],
    );
  }

  /// horizon list
  Widget _horizon(BuildContext context) {
    if (product == null) {
      return _horizonShimmer(context);
    } else {
      if (product.data.isEmpty) {
        return _empty(context);
      }
      return _horizonList(context);
    }
  }

  Widget _horizonList(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: horizonHeight,
      child: ListView.builder(
        shrinkWrap: true,
        padding: padding,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: showSeeAll ? product.data.length + 1 : product.data.length,
        itemBuilder: (context, index) {
          if (index == product.data.length) {
            return GestureDetector(
              onTap: seeAll,
              child: Container(
                width: horizonWidth,
                margin: EdgeInsets.only(
                  left: index == 0 ? 0 : 10,
                  right: 10,
                  bottom: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: AppStyles.radiusNormal,
                    border: Border.all(color: AppColors.dark45)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_forward_ios_outlined,
                        color: AppColors.dark45),
                    SizedBox(height: 6),
                    Text('See more'),
                  ],
                ),
              ),
            );
          }

          final item = product.data[index];
          return GestureDetector(
            onTap: () => onTap(item),
            child: Container(
              width: horizonWidth,
              margin: EdgeInsets.only(
                left: index == 0 ? 0 : 10,
                right: 10,
                bottom: 10,
                top: 10,
              ),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: AppStyles.radiusNormal,
                boxShadow: AppStyles.shadow,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: _imageItem(item.images)),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: /*nameStyle*/ theme.textTheme.bodyText2,
                        ),
                        const SizedBox(height: 4),
                        _money(item.discount, item.price,
                            theme.textTheme.bodyText2),
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

  Widget _horizonShimmer(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: horizonHeight,
      child: ListView.builder(
        shrinkWrap: true,
        padding: padding,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: horizonWidth,
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : 10,
              right: 10,
              bottom: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: AppStyles.radiusNormal,
              boxShadow: AppStyles.shadow,
            ),
            child: Shimmer.fromColors(
              baseColor: theme.cardColor,
              highlightColor: theme.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _imageItem([]),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(color: Colors.white, height: 6),
                        const SizedBox(height: 4),
                        Container(color: Colors.white, height: 6),
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

  /// vertical list
  Widget _vertical(BuildContext context) {
    if (product == null) {
      return _verticalShimmer(context);
    } else {
      if (product.data.isEmpty) {
        return _empty(context);
      }
      return _verticalList(context);
    }
  }

  Widget _verticalList(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: verticalShrinkWrap,
          padding: padding.copyWith(top: 10),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: verticalRatio,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
          ),
          itemCount: product.data.length,
          itemBuilder: (context, index) {
            final item = product.data[index];
            return GestureDetector(
              onTap: () => onTap(item),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: AppStyles.radiusNormal,
                  boxShadow: AppStyles.shadow,
                ),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: SizedBox(
                          width: double.infinity,
                          child: _imageItem(item.images)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            item.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyText1,
                          ),
                          _money(item.discount, item.price,
                              theme.textTheme.bodyText1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (loadingMore) const WidgetLoading()
      ],
    );
  }

  Widget _verticalShimmer(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          padding: padding,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: AppStyles.radiusNormal,
                boxShadow: AppStyles.shadow,
              ),
              child: Shimmer.fromColors(
                baseColor: theme.cardColor,
                highlightColor: theme.primaryColor,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: _imageItem([]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(color: Colors.white, height: 10, width: double.infinity),
                          const SizedBox(height: 4),
                          Container(color: Colors.white, height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  ///
  Widget _title(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label ?? '',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          if (!showSeeAll)
            const SizedBox()
          else
            GestureDetector(
              onTap: seeAll,
              child: Text(
                'See all',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            )
        ],
      ),
    );
  }

  Widget _imageItem(List<ProductImage> images) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: AppStyles.radiusNormal.topRight),
      child: WidgetImage(
          image: images.isEmpty ? null : images.first.image, fit: BoxFit.cover),
    );
  }

  Widget _money(int discount, int price, TextStyle style) {
    if (discount == 0) {
      return Align(
        alignment: Alignment.centerRight,
        child: Text(
          Formats.money(price),
          style: /*priceStyle*/ style,
        ),
      );
    } else {
      final p = price * ((100 - discount) / 100);
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(Formats.money(p), style: /*priceStyle*/ style),
          const SizedBox(width: 4),
          Text(
            Formats.money(price),
            style: style.copyWith(
              fontSize: 10,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      );
    }
  }

  Widget _empty(BuildContext context) {
    return const SizedBox(
      height: horizonHeight,
      child: Center(child: Text('Nothing to show')),
    );
  }
}
