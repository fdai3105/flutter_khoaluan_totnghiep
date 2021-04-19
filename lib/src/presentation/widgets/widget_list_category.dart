import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';
import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class WidgetListCategory extends StatelessWidget {
  final Category category;
  final bool isLoading;

  const WidgetListCategory({
    Key key,
    this.category,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _shimmer(context);
    } else {
      if (category.data.isEmpty) {
        return const SizedBox();
      }
      return Expanded(
        child: GlowingOverscrollIndicator(
          color: AppColors.primary,
          axisDirection: AxisDirection.down,
          child: GridView.builder(
            padding: AppStyles.paddingBody,
            itemCount: category.data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 0.7,
            ),
            itemBuilder: (context, index) {
              return _item(context, category.data[index]);
            },
          ),
        ),
      );
    }
  }

  Widget _item(BuildContext context, CategoryDatum category) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: CategoryScreen(
            id: category.id,
            parentName: category.name,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 106,child: WidgetImage(image: category.image)),
          const SizedBox(height: 4),
          Text(
            category.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _shimmer(BuildContext context) {
    return Expanded(
      child: GlowingOverscrollIndicator(
        color: AppColors.primary,
        axisDirection: AxisDirection.down,
        child: GridView.builder(
          padding: AppStyles.paddingBody,
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1 / 0.7,
          ),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: AppColors.shimmerBase,
              highlightColor: AppColors.shimmerHighlight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: Container(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Container(
                      color: Colors.grey,
                      width: double.infinity,
                      child: const Text('')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
