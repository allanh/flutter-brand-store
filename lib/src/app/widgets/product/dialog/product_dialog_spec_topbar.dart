// 標題列
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../device/utils/my_plus_colors.dart';
import '../../../../domain/entities/product/spec_sku.dart';
import '../../../../extension/num_extension.dart';

import '../../../../domain/entities/product/product.dart';

/// 選規 Dialog 的標題列
class ProductDialogSpecTopBarWidget extends StatelessWidget {
  final AddToCartParams selectedParams; // 已選的規格
  final SpecType? specType; // 規格類型
  final double? promotionRate; // 折數
  final AddToCartParams? selectedSpec;

  ProductInfo? get _info => selectedParams.selectedProductInfo;

  const ProductDialogSpecTopBarWidget({
    Key? key,
    required this.selectedParams,
    this.specType = SpecType.none,
    this.promotionRate,
    this.selectedSpec,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return SizedBox(
        height: 125,
        child: Stack(
          children: [
            // 背景
            _buildBackground(),

            // 商品價格
            Positioned(
                left: 124,
                right: 20,
                top: 20,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 售價
                    _buildPrice(context),

                    // 市價
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                        ),
                        child: Text(
                          _info?.marketPrice?.toDollarString() ?? '',
                          textAlign: TextAlign.left,
                          style: _theme.textTheme.caption!.copyWith(
                            height: 1.7142857, // 24pt
                            color: UdiColors.brownGrey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        )),

                    // 已選規格字串
                    if (SpecType.none != specType ||
                        selectedSpec?.quantity != null)
                      _buildSelectedSpec(context),
                  ],
                )),

            // 商品圖片
            _buildImage(),

            // 關閉鍵
            _buildClose(context),
          ],
        ));
  }

  /// 背景
  Widget _buildBackground() => Positioned(
      left: 0,
      right: 0,
      top: 15,
      bottom: 0,
      child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: const SizedBox.shrink()));

  /// 圖片
  Widget _buildImage() => Positioned(
      left: 12,
      child: SizedBox(
          width: 100,
          child: AspectRatio(
              aspectRatio: 1,
              child: _info?.imageUrl?.isNotEmpty == true
                  ? CachedNetworkImage(
                      imageUrl: _info!.imageUrl!,
                      fit: BoxFit.fill,
                      alignment: Alignment.topCenter,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : const Icon(Icons.error))));

  /// 價格
  Widget _buildPrice(BuildContext context) => Row(
        children: [
          if (_info?.proposedPrice != null)
            // 網路價
            Text(_info?.proposedPrice?.toDollarString() ?? '',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    height: 1.388888, // 25pt
                    color: UdiColors.strawberry,
                    fontSize: 18.0)),

          // 折扣折數
          if (promotionRate != null)
            Container(
              height: 24,
              padding:
                  const EdgeInsets.only(top: 3, bottom: 3, left: 6, right: 6),
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: UdiColors.strawberry,
                  borderRadius: BorderRadius.circular(2)),
              child: Text(
                '${promotionRate ?? ''}折',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(fontSize: 12.0, color: Colors.white),
              ),
            ),
        ],
      );

  /// 已選規格
  Widget _buildSelectedSpec(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(fontSize: 14.0, color: UdiColors.greyishBrown) ??
            const TextStyle(),
        child: SizedBox(
            height: 24,
            child: Wrap(children: [
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: "已選 ",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          fontSize: 14.0, color: UdiColors.brownGrey)),
                  // 出貨日期
                  if (selectedSpec?.deliveryDate?.isNotEmpty == true)
                    TextSpan(text: '${selectedSpec?.deliveryDate}, '),

                  // 規格1
                  if (_info?.specLv1Name?.isNotEmpty == true)
                    TextSpan(text: _info?.specLv1Name!),

                  // 規格2
                  if (_info?.specLv2Name?.isNotEmpty == true)
                    TextSpan(text: ', ${_info?.specLv2Name!}'),

                  // 數量
                  if (selectedSpec?.quantity != null)
                    TextSpan(
                        text: ', ${selectedSpec?.quantity}',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            fontSize: 14.0, color: UdiColors.strawberry)),
                  if (selectedSpec?.quantity != null)
                    const TextSpan(text: " 件"),
                ]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ])));
  }

  /// 關閉鍵
  Widget _buildClose(BuildContext context) => Positioned(
      top: 11,
      right: 0,
      child: InkWell(
        onTap: () => context.pop(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset('assets/images/icon_close_20px.png'),
        ),
      ));
}
