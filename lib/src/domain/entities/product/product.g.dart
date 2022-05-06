// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      goodsId: json['goods_id'] as String?,
      goodsNo: json['goods_no'] as String?,
      goodsStatus: json['goods_status'] as String?,
      name: json['name'] as String?,
      goodsType: json['goods_type'] as String?,
      categoryMain: json['category_main'] == null
          ? null
          : CategoryMain.fromJson(
              json['category_main'] as Map<String, dynamic>),
      categorySub: (json['category_sub'] as List<dynamic>?)
          ?.map((e) => CategoryMain.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageInfo: (json['image_info'] as List<dynamic>?)
          ?.map((e) => ImageInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      specType: json['spec_type'] as String?,
      specLv1Display: json['specLv1_display'] as String?,
      specLv1Title: json['specLv1_title'] as String?,
      specLv2Display: json['specLv2_display'] as String?,
      specLv2Title: json['specLv2_title'] as String?,
      specSku: (json['spec_sku'] as List<dynamic>?)
          ?.map((e) => SpecSku.fromJson(e as Map<String, dynamic>))
          .toList(),
      specInfo1: (json['spec_info1'] as List<dynamic>?)
          ?.map((e) => SpecSku.fromJson(e as Map<String, dynamic>))
          .toList(),
      specInfo2: (json['spec_info2'] as List<dynamic>?)
          ?.map((e) => SpecSku.fromJson(e as Map<String, dynamic>))
          .toList(),
      promotionApp: json['promotion_app'] == null
          ? null
          : Promotion.fromJson(json['promotion_app'] as Map<String, dynamic>),
      brandName: json['brand_name'] as String?,
      countryOfOrigin: json['country_of_origin'] as String?,
      material: json['material'] as String?,
      model: json['model'] as String?,
      unitName: json['unit_name'] as String?,
      isAppOnly: json['is_app_only'] as bool?,
      isRestricted: json['is_restricted'] as bool?,
      isRecycle: json['is_recycle'] as bool?,
      isLarge: json['is_large'] as bool?,
      shelfStatus: json['shelf_status'] as String?,
      startedAt: json['started_at'] as String?,
      endedAt: json['ended_at'] as String?,
      isFavorite: json['is_favorite'] as bool?,
      stockStatus: json['stock_status'] as String?,
      shippedType: json['shipped_type'] as String?,
      shippedPreorderDate: (json['shipped_preorder_date'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      shippedCustomDay: json['shipped_custom_day'] as String?,
      specialDescription: json['special_description'] as String?,
      description: json['description'] as String?,
      tags: json['tags'] as String?,
      expiry: json['expiry'] as String?,
      expireDate: json['expire_date'] as String?,
      expireDateType: json['expire_date_type'] as String?,
      length: (json['length'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      boxLength: (json['box_length'] as num?)?.toDouble(),
      boxWidth: (json['box_width'] as num?)?.toDouble(),
      boxHeight: (json['box_height'] as num?)?.toDouble(),
      boxWeight: (json['box_weight'] as num?)?.toDouble(),
      temperatureLayer: json['temperature_layer'] as String?,
      shippedMethod: (json['shipped_method'] as List<dynamic>?)
          ?.map((e) => ShippedMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentInfo: json['payment_info'] == null
          ? null
          : Payment.fromJson(json['payment_info'] as Map<String, dynamic>),
      bonusBankInfo: json['bonus_bank_info'] == null
          ? null
          : BonusBankInfo.fromJson(
              json['bonus_bank_info'] as Map<String, dynamic>),
      productInfo: (json['product_info'] as List<dynamic>?)
          ?.map((e) => ProductInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      recomList: (json['recom_list'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      freebieInfo: (json['freebie_info'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      addonInfo: (json['addon_info'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      product: json['product'] == null
          ? null
          : ProductInfo.fromJson(json['product'] as Map<String, dynamic>),
      eventList: (json['event_list'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      slidingImage: (json['sliding_image'] as List<dynamic>?)
          ?.map((e) => ImageInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      freebieBuyNum: json['freebie_buy_num'] as int?,
      freebieGiftNum: json['freebie_gift_num'] as int?,
      freebieGiftLimitOn: json['freebie_gift_limit_on'] as int?,
      freebieGiftLimit: json['freebie_gift_limit'] as int?,
      addonFixedPrice: json['addon_fixed_price'] as int?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'goods_id': instance.goodsId,
      'goods_no': instance.goodsNo,
      'goods_status': instance.goodsStatus,
      'name': instance.name,
      'goods_type': instance.goodsType,
      'category_main': instance.categoryMain,
      'category_sub': instance.categorySub,
      'image_info': instance.imageInfo,
      'spec_type': instance.specType,
      'specLv1_display': instance.specLv1Display,
      'specLv1_title': instance.specLv1Title,
      'specLv2_display': instance.specLv2Display,
      'specLv2_title': instance.specLv2Title,
      'spec_sku': instance.specSku,
      'spec_info1': instance.specInfo1,
      'spec_info2': instance.specInfo2,
      'promotion_app': instance.promotionApp,
      'brand_name': instance.brandName,
      'country_of_origin': instance.countryOfOrigin,
      'material': instance.material,
      'model': instance.model,
      'unit_name': instance.unitName,
      'is_app_only': instance.isAppOnly,
      'is_restricted': instance.isRestricted,
      'is_recycle': instance.isRecycle,
      'is_large': instance.isLarge,
      'shelf_status': instance.shelfStatus,
      'started_at': instance.startedAt,
      'ended_at': instance.endedAt,
      'is_favorite': instance.isFavorite,
      'stock_status': instance.stockStatus,
      'shipped_type': instance.shippedType,
      'shipped_preorder_date': instance.shippedPreorderDate,
      'shipped_custom_day': instance.shippedCustomDay,
      'special_description': instance.specialDescription,
      'description': instance.description,
      'tags': instance.tags,
      'expiry': instance.expiry,
      'expire_date': instance.expireDate,
      'expire_date_type': instance.expireDateType,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
      'weight': instance.weight,
      'box_length': instance.boxLength,
      'box_width': instance.boxWidth,
      'box_height': instance.boxHeight,
      'box_weight': instance.boxWeight,
      'temperature_layer': instance.temperatureLayer,
      'shipped_method': instance.shippedMethod,
      'payment_info': instance.paymentInfo,
      'bonus_bank_info': instance.bonusBankInfo,
      'product_info': instance.productInfo,
      'recom_list': instance.recomList,
      'freebie_info': instance.freebieInfo,
      'addon_info': instance.addonInfo,
      'product': instance.product,
      'event_list': instance.eventList,
      'sliding_image': instance.slidingImage,
      'freebie_buy_num': instance.freebieBuyNum,
      'freebie_gift_num': instance.freebieGiftNum,
      'freebie_gift_limit_on': instance.freebieGiftLimitOn,
      'freebie_gift_limit': instance.freebieGiftLimit,
      'addon_fixed_price': instance.addonFixedPrice,
    };

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) => ProductInfo(
      lvl: json['lvl'] as int?,
      storeNo: json['store_no'] as String?,
      productStatus: json['product_status'] as String?,
      productId: json['product_id'] as int?,
      productNo: json['product_no'] as String?,
      productName: json['product_name'] as String?,
      specNo: json['spec_no'] as String?,
      specLv1Id: json['spec_lv_1_id'] as int?,
      specLv1Name: json['spec_lv_1_name'] as String?,
      specLv2Id: json['spec_lv_2_id'] as int?,
      specLv2Name: json['spec_lv_2_name'] as String?,
      store: json['store'] as String?,
      quantity: json['quantity'] as int?,
      safeStock: json['safe_stock'] as int?,
      saleLimit: json['sale_limit'] as int?,
      cost: json['cost'] as int?,
      marketPrice: json['market_price'] as int?,
      proposedPrice: json['proposed_price'] as int?,
      promotionPriceApp: json['promotion_price_app'] as int?,
      urlGroupId: json['url_group_id'] as String?,
      imageUrl: json['image_url'] as String?,
      imageInfo: (json['image_info'] as List<dynamic>?)
          ?.map((e) => ImageInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      tagProd: json['tagProd'] == null
          ? null
          : Tag.fromJson(json['tagProd'] as Map<String, dynamic>),
      tag: json['tag'] == null
          ? null
          : Tag.fromJson(json['tag'] as Map<String, dynamic>),
      stagePriceBestApp: json['stagePriceBestApp'] == null
          ? null
          : StagingInfo.fromJson(
              json['stagePriceBestApp'] as Map<String, dynamic>),
      stagePriceInfoApp: (json['stagePriceInfoApp'] as List<dynamic>?)
          ?.map((e) => StagingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'lvl': instance.lvl,
      'store_no': instance.storeNo,
      'product_status': instance.productStatus,
      'product_id': instance.productId,
      'product_no': instance.productNo,
      'product_name': instance.productName,
      'spec_no': instance.specNo,
      'spec_lv_1_id': instance.specLv1Id,
      'spec_lv_1_name': instance.specLv1Name,
      'spec_lv_2_id': instance.specLv2Id,
      'spec_lv_2_name': instance.specLv2Name,
      'store': instance.store,
      'quantity': instance.quantity,
      'safe_stock': instance.safeStock,
      'sale_limit': instance.saleLimit,
      'cost': instance.cost,
      'market_price': instance.marketPrice,
      'proposed_price': instance.proposedPrice,
      'promotion_price_app': instance.promotionPriceApp,
      'url_group_id': instance.urlGroupId,
      'image_url': instance.imageUrl,
      'image_info': instance.imageInfo,
      'tagProd': instance.tagProd,
      'tag': instance.tag,
      'stagePriceBestApp': instance.stagePriceBestApp,
      'stagePriceInfoApp': instance.stagePriceInfoApp,
    };
