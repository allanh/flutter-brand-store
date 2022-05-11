import 'package:flutter/material.dart';

import '../../../domain/entities/module/product_list_item.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductListItem item;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child:
              (item.image != null) ? Image.network(item.image!) : Container(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 15.0, top: 8.0),
            child: Text(item.name),
          ),
        ),
      ],
    );
  }
}
