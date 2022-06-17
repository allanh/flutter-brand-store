import 'package:flutter/material.dart';

import '../common/no_wrap_row.dart';

/// 商品標籤列
class ProductTagsRowWidget extends StatelessWidget {
  const ProductTagsRowWidget({Key? key, required this.tags}) : super(key: key);

  final String tags;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    tags.split(',').forEach((tag) {
      list.add(Text('#$tag',
          style: Theme.of(context).textTheme.caption?.copyWith(
              fontSize: 14.0,
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline)));
    });

    return NoWrapRow(
      maxHeight: 20,
      spacing: 10,
      children: list,
    );
  }
}
