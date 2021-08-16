import 'package:flutter/material.dart';

class ImageNetworkCustom extends StatelessWidget {
  final String url;
  final double sizeIcon;
  final BoxFit fit;
  final Color? color;
  final double? height;
  final double? width;

  const ImageNetworkCustom({
    Key? key,
    required this.url,
    this.sizeIcon = 32,
    this.fit = BoxFit.contain,
    this.color,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      color: color,
      errorBuilder: (context, object, stackTrace) {
        return Center(
          child: Container(
              color: color,
              height: height,
              width: width,
              child: Icon(
                Icons.broken_image,
                color: Theme.of(context).colorScheme.secondaryVariant,
                size: sizeIcon,
              )),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: Container(
            color: color,
            height: height,
            width: width,
            child: Icon(
              Icons.image,
              color: Theme.of(context).colorScheme.onSecondary,
              size: sizeIcon,
            ),
          ),
        );
      },
    );
  }
}
