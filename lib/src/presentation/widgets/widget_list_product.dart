import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../configs/configs.dart';
import '../../resources/resources.dart';

class WidgetListProduct extends StatefulWidget {
  final ProductPagination product;
  final String label;
  final Function seeAll;
  final Function(Product) onTap;
  final bool isVertical;
  final bool loadingMore;

  const WidgetListProduct({
    Key key,
    this.product,
    this.label,
    this.seeAll,
    this.onTap,
    this.isVertical = false,
    this.loadingMore = false,
  }) : super(key: key);

  @override
  _WidgetListProductState createState() => _WidgetListProductState();
}

class _WidgetListProductState extends State<WidgetListProduct> {
  static const double horizonWidth = 124;
  static const double horizonHeight = 200;
  static const double verticalRatio = 0.85;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(),
        _body(context),
      ],
    );
  }

  Widget _body(BuildContext context) {
    if (widget.isVertical) {
      return widget.product == null
          ? _verticalShimmer(context)
          : _vertical(context);
    } else {
      return (widget.product == null)
          ? _horizonShimmer(context)
          : _horizon(context);
    }
  }

  Widget _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.label ?? '',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () => widget.seeAll,
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

  Widget _horizon(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: horizonHeight,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.product.data.length,
        itemBuilder: (context, index) {
          final item = widget.product.data[index];
          return GestureDetector(
            onTap: () => widget.onTap(item),
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
                borderRadius: BorderRadius.circular(6),
                boxShadow: AppStyles.shadow,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: _imageItem(item.images)),
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

  Widget _horizonShimmer(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: horizonHeight,
      child: ListView.builder(
        shrinkWrap: true,
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
              borderRadius: BorderRadius.circular(6),
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
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: verticalRatio,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: widget.product.data.length,
          itemBuilder: (context, index) {
            final item = widget.product.data[index];
            return GestureDetector(
              onTap: () => widget.onTap(item),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
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
                            style: const TextStyle(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
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
        if (widget.loadingMore) const Center(child: CircularProgressIndicator())
      ],
    );
  }

  Widget _verticalShimmer(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
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
                borderRadius: BorderRadius.circular(6),
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
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(6),
      ),
      child: images.isEmpty
          ? Image.asset(
              'assets/images/placeholder.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            )
          : FadeInImage.assetNetwork(
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
              image: AppEndpoint.domain + images.first.image,
              placeholder: 'assets/images/placeholder.jpg',
            ),
    );
  }
}
