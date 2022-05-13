import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../pages/home/home_controller.dart';

import '../../../domain/entities/module/module.dart';

import '../home/module_title_widget.dart';
import './product_item_widget.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.module,
  }) : super(key: key);

  final Module module;
  @override
  Widget build(BuildContext context) {
    final int length = module.products!.length;
    final items = module.products!;
    final controller =
        FlutterCleanArchitecture.getController<HomeController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (module.showTitle)
            ? GestureDetector(
                onTap: () => controller.onTap(module.titleLink),
                child: ModuleTitleWidget(
                  module: module,
                  showMore: true,
                ),
              )
            : Container(
                decoration: const BoxDecoration(color: Colors.red),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GestureDetector(
            onTap: () => {},
            child: GridView.builder(
              itemCount: length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3.0 / 4.0,
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 6.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                // return const Text('grid view item builder');
                return ProductItemWidget(item: items[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
