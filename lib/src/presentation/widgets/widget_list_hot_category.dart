import 'package:flutter/material.dart';
import '../../configs/configs.dart';

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
          _item('assets/icons/bed.png', 'Bed'),
          _item('assets/icons/cabinet.png', 'Cabinet'),
          _item('assets/icons/cabinet_tivi.png', 'Tivi'),
          _item('assets/icons/chair.png', 'Chair'),
          _item('assets/icons/wardrobe.png', 'Wardrobe'),
        ],
      ),
    );
  }

  Widget _item(String image, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
