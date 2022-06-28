import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Gallery 縮圖
class GallerySmallImageWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onImageTap;
  final bool selected;

  const GallerySmallImageWidget(
      {Key? key,
      required this.imagePath,
      this.selected = false,
      required this.onImageTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return InkWell(
          onTap: onImageTap,
          child: AspectRatio(
              aspectRatio: 1,
              child: Stack(children: [
                CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                // 蓋一層白色在未選取的縮圖，
                if (!selected)
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.6)),
                  )
              ])));
    });
  }
}
