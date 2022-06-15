import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product/product.dart';
import 'product_divider_widget.dart';

/// 商品介紹
class ProductIntroductionWidget extends StatelessWidget {
  const ProductIntroductionWidget({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          margin: const EdgeInsets.only(top: 8),
          color: Colors.white,
          child: Column(
            children: [
              _title(context),
              // 商品介紹內容
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    children: [
                      // 第一張商品圖片
                      if (product.firstImage != null)
                        _image(product.firstImage),
                      const SizedBox(height: 16),
                      Container(
                        color: Colors.white,
                        child: Table(
                          border: TableBorder.all(color: UdiColors.divider),
                          columnWidths: {
                            0: FlexColumnWidth(100 * SizeConfig.screenRatio),
                            1: FlexColumnWidth(251 * SizeConfig.screenRatio),
                          },
                          children: [
                            // 品牌名稱
                            if (product.brandName != null)
                              TableRow(children: [
                                _titleCell(context, '品牌名稱'),
                                _valueCell(context, product.brandName!),
                              ]),

                            // 鑑賞期
                            if (product.orderHesitate != null)
                              TableRow(children: [
                                _titleCell(context, '鑑賞期'),
                                _valueCell(context, product.orderHesitate!),
                              ]),

                            // 保存期限
                            if (product.expiryString != null)
                              TableRow(children: [
                                _titleCell(context, '保存期限'),
                                _valueCell(context, product.expiryString!),
                              ]),

                            // 原產地
                            if (product.countryOfOrigin != null)
                              TableRow(children: [
                                _titleCell(context, '原產地'),
                                _valueCell(context, product.countryOfOrigin!),
                              ]),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ));
    });
  }

  // 標題
  Widget _title(BuildContext context) => Container(
      height: 41,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.only(left: 12, top: 10),
            child: Text('商品介紹',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 14.0, color: Theme.of(context).primaryColor))),
        const SizedBox(
          height: 10,
        ),
        ProductDividerWidget(
          dividerWidth: SizeConfig.screenWidth,
        )
      ]));

  // 商品圖片
  Widget _image(String? url) {
    return url != null
        ? AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ))
        : const Icon(Icons.error);
  }

  // 標題格
  Widget _titleCell(BuildContext context, String text) => TableCell(
      child: Container(
          alignment: Alignment.center,
          height: 36,
          color: UdiColors.white2,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: UdiColors.brownGrey),
          )));

  // 內容格
  Widget _valueCell(BuildContext context, String text) => TableCell(
      child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 36,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: UdiColors.greyishBrown),
          )));
}
