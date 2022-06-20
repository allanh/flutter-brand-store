import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({Key? key, required this.imageUrls}) : super(key: key);

  final List<String> imageUrls;

  final double height = 160.0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
              imageUrls.length,
              (index) => Image(
                  image: ResizeImage(NetworkImage(imageUrls[index]),
                      width: MediaQuery.of(context).size.width.toInt(),
                      height: height.toInt()))),
        ));
  }
}
