import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../device/utils/my_plus_colors.dart';

class AspectRatioImage extends StatelessWidget {
  const AspectRatioImage({
    Key? key,
    this.url,
    this.isEnabled,
    this.ratio = 1,
  }) : super(key: key);

  final String? url;
  final bool? isEnabled;
  final double ratio;

  @override
  Widget build(BuildContext context) => url != null
      ? AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: url!,
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            color: isEnabled == true ? null : UdiColors.brownGrey2,
            colorBlendMode: BlendMode.modulate,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ))
      : const Icon(Icons.error);
}
