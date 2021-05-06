import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

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
      return CachedNetworkImage(
        imageUrl: AppEndpoint.domain + image,
        fit: fit,
        progressIndicatorBuilder: (context, url, progress) {
          return Center(
            child: CircularProgressIndicator(
              value: progress.progress,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          );
        },
        // placeholder: (context, url) {
        //   return Center(child: const CircularProgressIndicator());
        // },
        errorWidget: (context, url, error) {
          return Image.asset(
            'assets/images/placeholder.jpg',
            fit: BoxFit.cover,
          );
        },
      );
    }
  }
}
