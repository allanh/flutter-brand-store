import 'package:flutter/material.dart';

import '../../../domain/entities/module/image_list_item.dart';

class ImageItemWidget extends StatelessWidget {
  const ImageItemWidget({
    Key? key,
    required this.item,
    required this.showContent,
    required this.ratio,
  }) : super(key: key);
  @required
  final ImageListItem item;
  final bool showContent;
  final double ratio;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final ratio = widget.module.size!.ratio;
    final height = width * ratio + (showContent ? 125.0 : 0.0);
    return (showContent)
        ? SizedBox(
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  item.image,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: width,
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: 8),
                          child: Text(item.title ?? ''),
                        ),
                      ),
                      SizedBox(
                        width: width,
                        height: 48,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: 8),
                          child: Text(item.content ?? ''),
                        ),
                      ),
                      SizedBox(
                        width: width,
                        height: 32,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: 8),
                          child: Text(item.start.toString() +
                              '-' +
                              item.end.toString()),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        : Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              SizedBox(
                width: width,
                height: height,
                child: Image.network(item.image),
              ),
            ],
          );
  }
}
