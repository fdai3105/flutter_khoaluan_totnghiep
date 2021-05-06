import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../configs/configs.dart';
import '../presentation.dart';

class WidgetAvatar extends StatelessWidget {
  final String image;
  final double size;

  const WidgetAvatar({Key key, this.image, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var child;
    if (image == null) {
      child = Image.asset(
        'assets/images/place_user.png',
        fit: BoxFit.cover,
      );
    } else {
      child = CachedNetworkImage(
        imageUrl: AppEndpoint.domain + image,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) {
          return Stack(
            children: [
              Image.asset(
                'assets/images/place_user.png',
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: WidgetLoading(progress: progress.progress),
              ),
            ],
          );
        },
        errorWidget: (context, url, err) {
          return Image.asset(
            'assets/images/place_user.png',
          );
        },
      );
    }

    return Container(
      height: size,
      width: size,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200, width: 2),
      ),
      child: ClipOval(child: child),
    );
  }
}
