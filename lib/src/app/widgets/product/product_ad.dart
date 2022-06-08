import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:flutter/material.dart';

class ProductAd extends StatelessWidget {
  const ProductAd({Key? key, required this.imageUrl, required this.height})
      : super(key: key);

  final String imageUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: Image(
          image: ResizeImage(NetworkImage(imageUrl),
              width: SizeConfig.screenWidth.toInt(), height: height.toInt()),
        ));
  }
}
