import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class WidgetImage extends StatelessWidget {
  final String image;

  const WidgetImage({
    Key key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Image.asset(
        'assets/images/placeholder.jpg',
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return FadeInImage.assetNetwork(
        image: AppEndpoint.domain + image,
        height: 106,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: 'assets/images/placeholder.jpg',
      );
    }
  }
}
