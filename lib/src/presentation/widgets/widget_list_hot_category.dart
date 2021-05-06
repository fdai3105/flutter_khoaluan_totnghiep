import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          _item('assets/icons/bed.png', 'Gường', () {
            pushNewScreen(
              context,
              screen: const CategoryScreen(
                id: 8,
                parentName: 'Gường',
                parentImage: 'upload/Gường_p4_d9b5b79a079c4085a4b5b9c7561cd8be_medium.png',
              ),
              withNavBar: false,
            );
          }),
          _item('assets/icons/table.png', 'Bàn', () {
            pushNewScreen(
              context,
              screen: const CategoryScreen(
                id: 1,
                parentName: 'Bàn',
                parentImage:
                'upload\Bàn_2_16b84acbefe24232a46fbf952a107bbd_medium.jpg',
              ),
              withNavBar: false,
            );
          }),
          _item('assets/icons/decorate.png', 'Trang trí', () {
            pushNewScreen(
              context,
              screen: const CategoryScreen(
                id: 10,
                parentName: 'Trang trí',
                parentImage:
                    'upload/Trang trí_vuong_1ff9b74779fe4ebdbbee01ba5c8c897e_medium.png',
              ),
              withNavBar: false,
            );
          }),
          _item('assets/icons/sofa.png', 'Sofa', () {
            pushNewScreen(
              context,
              screen: const CategoryScreen(
                id: 7,
                parentName: 'Sofa',
                parentImage:
                    'upload/Sofa_4_ce368213d8d546bfa4970d12f1eedad0_medium.png',
              ),
              withNavBar: false,
            );
          }),
          _item('assets/icons/lamp.png', 'Đèn', () {
            pushNewScreen(
              context,
              screen: const CategoryScreen(
                id: 4,
                parentName: 'Đèn',
                parentImage:
                    'upload/Đèn_pixar_d_12f93e1649744f1e8e5f6ece7e6e4744_medium.jpg',
              ),
              withNavBar: false,
            );
          }),
          _item('assets/icons/mirror.png', 'Gương', () {
            pushNewScreen(
              context,
              screen: const CategoryScreen(
                id: 6,
                parentName: 'Gương',
                parentImage:
                'upload/Gương_2_178bb757c9d742c7ae1fc8c2f807db7d_medium.jpg',
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
          color: AppColors.tertiary,
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
