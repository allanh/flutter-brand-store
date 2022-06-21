import 'package:brandstores/src/app/pages/static_view.dart';
import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../device/utils/my_plus_colors.dart';
import '../../../../domain/entities/product/product.dart';
import '../../../../domain/entities/product/promotion.dart';
import 'product_dialog_spec_topbar.dart';

class ProductSpecWidget extends StatefulWidget {
  final Product product;
  final int? productId;

  const ProductSpecWidget({Key? key, required this.product, this.productId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductSpecWidgetState();
}

class _ProductSpecWidgetState extends State<ProductSpecWidget> {
  // 規格品列表
  List<ProductInfo> get _infos => widget.product.productInfo ?? [];
  // 目前規格
  ProductInfo? _currentInfo;
  // 出貨日期
  String? preorderDate;
  // 數量
  double? quantity;

  @override
  void initState() {
    if (widget.productId != null &&
        _infos.any((element) => widget.productId == element.productId)) {
      _currentInfo =
          _infos.firstWhere((element) => widget.productId == element.productId);
    } else {
      _currentInfo = _infos.first;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => (_currentInfo != null)
      ? Container(
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: SingleChildScrollView(
              child: Column(
            children: [
              // 選規標題列
              ProductDialogSpecTopBarWidget(
                info: _currentInfo!,
                specType: widget.product.specType,
                promotionRate:
                    (widget.product.promotionApp?.type == PromotionType.rate)
                        ? widget.product.promotionApp?.rate
                        : null,
                preorderDate: preorderDate,
                quantity: quantity,
              ),
            ],
          )))
      : const StaticPage(
          pageType: StaticPageType.error500,
        );
}
