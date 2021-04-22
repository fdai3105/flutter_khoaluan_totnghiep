import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class WidgetImage extends StatelessWidget {
  final String image;
  final BoxFit fit;

  const WidgetImage({
    Key key,
    this.image,
    this.fit = BoxFit.contain,
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
        width: double.infinity,
        fit: fit,
        placeholder: 'assets/images/placeholder.jpg',
      );
    }
  }
}
