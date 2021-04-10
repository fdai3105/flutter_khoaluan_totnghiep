import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class WidgetListProduct extends StatelessWidget {
  final Products product;
  final String label;
  final EdgeInsets padding;
  final Function seeAll;
  final Function(ProductDatum) onTap;
  final bool isVertical;
  final bool verticalShrinkWrap;
  final bool loadingMore;
  final bool showSeeAll;

  const WidgetListProduct({
    Key key,
    this.product,
    this.label,
    this.padding = const EdgeInsets.all(0),
    this.seeAll,
    this.onTap,
    this.isVertical = false,
    this.loadingMore = false,
    this.showSeeAll = true,
    this.verticalShrinkWrap = true,
  }) : super(key: key);

  static const double horizonWidth = 124;
  static const double horizonHeight = 200;
  static const double verticalRatio = 0.85;

  ///
  static final TextStyle nameStyle = GoogleFonts.inter(
    color: AppColors.dark,
    fontWeight: FontWeight.w600,
  );

  ///
  static final TextStyle priceStyle = GoogleFonts.inter(
    color: AppColors.dark,
  );

  ///
  static final TextStyle titleStyle = GoogleFonts.inter(
    fontSize: 18,
    color: AppColors.dark,
    fontWeight: FontWeight.w600,
  );

  ///
  static const TextStyle buttonTextStyle = TextStyle(
    color: AppColors.dark45,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label == null && !showSeeAll) const SizedBox() else _title(),
        _body(context),
      ],
    );
  }

  Widget _title() {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label ?? '',
            style: titleStyle,
          ),
          if (!showSeeAll)
            const SizedBox()
          else
            GestureDetector(
              onTap: () => seeAll,
              child: const Text(
                'See all',
                style: buttonTextStyle,
              ),
            )
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    if (isVertical) {
      return product == null ? _verticalShimmer(context) : _vertical(context);
    } else {
      return (product == null) ? _horizonShimmer(context) : _horizon(context);
    }
  }

  Widget _horizon(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: horizonHeight,
      child: ListView.builder(
        shrinkWrap: true,
        padding: padding,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: product.data.length + 1,
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
                    color: Colors.white,
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
                color: Colors.white,
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
                          style: nameStyle,
                        ),
                        const SizedBox(height: 4),
                        Text('${item.price} vnd', style: priceStyle),
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
              color: Colors.white,
              borderRadius: AppStyles.radiusNormal,
              boxShadow: AppStyles.shadow,
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
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(color: Colors.grey, height: 6),
                        const SizedBox(height: 4),
                        Container(color: Colors.grey, height: 6),
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

  Widget _vertical(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: verticalShrinkWrap,
          padding: padding.copyWith(top: 10),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: verticalRatio,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: product.data.length,
          itemBuilder: (context, index) {
            final item = product.data[index];
            return GestureDetector(
              onTap: () => onTap(item),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppStyles.radiusNormal,
                  boxShadow: AppStyles.shadow,
                ),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: _imageItem(item.images),
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
                            style: nameStyle,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${item.price} vnd',
                            style: priceStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (loadingMore) const Center(child: CircularProgressIndicator())
      ],
    );
  }

  Widget _verticalShimmer(BuildContext context) {
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
                color: Colors.white,
                borderRadius: AppStyles.radiusNormal,
                boxShadow: AppStyles.shadow,
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
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
      ],
    );
  }

  Widget _imageItem(List<ProductImage> images) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: AppStyles.radiusNormal.topRight),
      child: WidgetImage(image: images.isEmpty ? null : images.first.image),
    );
  }
}
