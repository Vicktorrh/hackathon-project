import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  const ImageWidget(
      {super.key,
      this.color,
      this.fit,
      this.height,
      required this.imagePath,
      this.width});

  @override
  Widget build(BuildContext context) {
    return imagePath.getimageType() == imageType.network
        ? CachedNetworkImage(
            imageUrl: imagePath,
            width: width,
            height: height,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            progressIndicatorBuilder: (context, url, progress) =>
                const Icon(Icons.image),
          )
        : imagePath.getimageType() == imageType.svg
            ? SvgPicture.asset(
                imagePath,
                width: width,
                height: height,
                color: color,
              )
            : imagePath.getimageType() == imageType.png
                ? Image.asset(
                    imagePath,
                    width: width,
                    height: height,
                  )
                : Image.asset(
                    imagePath,
                    width: width,
                    height: height,
                  );
  }
}

enum imageType { network, png, svg, jpeg }

extension CheckTheImageType on String {
  imageType getimageType() {
    if (this.startsWith('http')) {
      return imageType.network;
    } else if (this.endsWith('.svg')) {
      return imageType.svg;
    } else if (this.endsWith('.png')) {
      return imageType.png;
    } else {
      return imageType.jpeg;
    }
  }
}
