import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class WidgetListCategory extends StatelessWidget {
  final Function(CategoryDatum) onTap;
  final Category category;
  final bool shrinkWrap;
  final bool isLoading;
  final Axis axis;

  const WidgetListCategory({
    Key key,
    @required this.onTap,
    @required this.category,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.axis = Axis.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return axis == Axis.vertical ? _vertical(context) : _horizontal(context);
  }

  Widget _vertical(BuildContext context) {
    if (isLoading) {
      return _shimmer(context);
    } else {
      if (category == null) {
        return const SizedBox();
      }
      if (category.data.isEmpty) {
        return const SizedBox();
      }
      return GridView.builder(
        shrinkWrap: shrinkWrap,
        physics: shrinkWrap
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        padding: AppStyles.paddingBody,
        itemCount: category.data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return _item(context, category.data[index]);
        },
      );
    }
  }

  Widget _horizontal(BuildContext context) {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: AppStyles.paddingBody,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: category.data.length,
        itemBuilder: (context, index) {
          final item = category.data[index];
          return GestureDetector(
            onTap: () => onTap(item),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: WidgetImage(
                    image: item.image,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _item(BuildContext context, CategoryDatum category) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onTap(category),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: AppStyles.radiusNormal,
          boxShadow: AppStyles.shadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      top: AppStyles.radiusNormal.bottomRight),
                  child: WidgetImage(
                    image: category.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  category.name ?? '',
                  style: Theme.of(context).textTheme.bodyText2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmer(BuildContext context) {
    final theme = Theme.of(context);

    return GlowingOverscrollIndicator(
      color: AppColors.primary,
      axisDirection: AxisDirection.down,
      child: GridView.builder(
        padding: AppStyles.paddingBody,
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1,
        ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Flexible(
                    fit: FlexFit.tight,
                    child: WidgetImage(image: null),
                  ),
                  const SizedBox(height: 4),
                  Flexible(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        color: Colors.grey,
                        width: double.infinity,
                        child: const Text(''),
                      ),
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
