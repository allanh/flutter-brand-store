import 'package:flutter/material.dart';
import '../../../domain/entities/product/product.dart';

/// 促銷活動
class ProductEvent extends StatelessWidget {
  const ProductEvent({Key? key, required this.product}) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) => Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row());
}
