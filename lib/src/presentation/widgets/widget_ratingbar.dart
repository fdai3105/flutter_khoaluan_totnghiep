import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../configs/configs.dart';

class WidgetRatingBar extends StatelessWidget {
  final double stars;
  final double size;

  const WidgetRatingBar({
    Key key,
    this.stars = 0,
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      glow: false,
      ignoreGestures: true,
      allowHalfRating: true,
      itemSize: size,
      initialRating: stars,
      unratedColor: Colors.grey.shade400,
      itemBuilder: (context, index) {
        return const Icon(Icons.star_outlined, color: AppColors.dark);
      },
      onRatingUpdate: (value) {},
    );
  }
}
