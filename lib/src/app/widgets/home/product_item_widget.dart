import 'package:brandstores/src/domain/entities/module/module.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ModuleItem item;
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
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 15.0, top: 8.0),
          child: Flexible(
            child: Text(item.name),
          ),
        ),
      ],
    );
  }
}
