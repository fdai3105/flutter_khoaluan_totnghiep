import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../configs/configs.dart';
import '../../resources/resources.dart';

class WidgetListProduct extends StatelessWidget {
  final ProductPagination product;
  final String label;
  final Function seeAll;
  final Function(Product) onTap;
  final bool isVertical;

  const WidgetListProduct({
    Key key,
    this.product,
    this.label,
    this.seeAll,
    this.onTap,
    this.isVertical = true,
  }) : super(key: key);

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
    if (isVertical) {
      return product == null ? _verticalShimmer(context) : _vertical(context);
    } else {
      return (product == null) ? _horizonShimmer(context) : _horizon(context);
    }
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

  Widget _horizon(BuildContext context) {
    const height = 200.0;
    const width = 150.0;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
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
              width: width,
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
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: 140,
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: product.data.length,
          itemBuilder: (context, index) {
            final item = product.data[index];
            return GestureDetector(
              onTap: () => onTap(item),
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
          : Image.network(
              AppEndpoint.domain + images.first.image,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
    );
  }
}
