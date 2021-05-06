// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// Project imports:
import '../../configs/configs.dart';
import '../category/category.dart';

class WidgetListHotCategory extends StatelessWidget {
  const WidgetListHotCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        padding: AppStyles.paddingBody,
        scrollDirection: Axis.horizontal,
        children: [
          _item('assets/icons/bed.png', 'Beds', () {
            pushNewScreen(
              context,
              screen: const CategoryScreen(
                id: 1,
                parentName: 'Beds',
                parentImage: 'upload/Beds_beds_bm003-us.webp',
              ),
              withNavBar: false,
            );
          }),
          _item('assets/icons/closet.png', 'Armories & wardrobes', () {
            pushNewScreen(
              context,
              screen: const CategoryScreen(
                id: 4,
                parentName: 'Armoires & wardrobes',
                parentImage: 'upload/Armoires & wardrobes_wardrobes_19053.webp',
              ),
              withNavBar: false,
            );
          }),
          _item('assets/icons/television.png', 'TV & media furniture', () {
            pushNewScreen(
              context,
              screen: const CategoryScreen(
                id: 7,
                parentName: 'TV & media furniture',
                parentImage:
                    'upload/TV & media furniture_Category_tv-and-media-storage.jpg',
              ),
              withNavBar: false,
            );
          }),
          _item('assets/icons/sofa.png', 'Sofas & sectionals', () {
            pushNewScreen(
              context,
              screen: const CategoryScreen(
                id: 3,
                parentName: 'Sofas & sectionals',
                parentImage:
                    'upload/Sofas & sectionals_Category_sofas-and-armchairs.jpg',
              ),
              withNavBar: false,
            );
          }),
          _item('assets/icons/cupboard.png', 'Dressers & storage drawer', () {
            pushNewScreen(
              context,
              screen: const CategoryScreen(
                id: 9,
                parentName: 'Dressers & storage drawers',
                parentImage:
                    'upload/Dressers & storage drawers_dressers-storage-drawers_st004-us.webp',
              ),
              withNavBar: false,
            );
          }),
        ],
      ),
    );
  }

  Widget _item(String image, String text, Function function) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                image,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
