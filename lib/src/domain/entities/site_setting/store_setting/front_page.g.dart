// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'front_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDisplayItem _$ProductDisplayItemFromJson(Map<String, dynamic> json) =>
    ProductDisplayItem(
      json['slogan'] as String?,
      (json['page'] as List<dynamic>)
          .map((e) => $enumDecode(_$PageEnumMap, e))
          .toList(),
      json['quantity'] as String?,
    )..format = $enumDecodeNullable(_$DiscountFormatEnumMap, json['format']);

Map<String, dynamic> _$ProductDisplayItemToJson(ProductDisplayItem instance) =>
    <String, dynamic>{
      'slogan': instance.slogan,
      'page': instance.pages.map((e) => _$PageEnumMap[e]).toList(),
      'quantity': instance.quantity,
      'format': _$DiscountFormatEnumMap[instance.format],
    };

const _$PageEnumMap = {
  Page.home: 'HOME',
  Page.category: 'CATEGORY',
  Page.search: 'SEARCH',
  Page.product: 'PRODUCT',
};

const _$DiscountFormatEnumMap = {
  DiscountFormat.chinese: 'CHINESE',
  DiscountFormat.percentage: 'PERCENTAGE',
};

ProductDisplay _$ProductDisplayFromJson(Map<String, dynamic> json) =>
    ProductDisplay(
      ProductDisplayItem.fromJson(json['sold_out'] as Map<String, dynamic>),
      ProductDisplayItem.fromJson(json['coming_soon'] as Map<String, dynamic>),
      ProductDisplayItem.fromJson(
          json['coming_to_an_end'] as Map<String, dynamic>),
      ProductDisplayItem.fromJson(
          json['promotion_few_left'] as Map<String, dynamic>),
      ProductDisplayItem.fromJson(
          json['promotion_new'] as Map<String, dynamic>),
      ProductDisplayItem.fromJson(
          json['promotion_category_purchase_amount_top_10']
              as Map<String, dynamic>),
      ProductDisplayItem.fromJson(
          json['promotion_category_collection_amount_top_10']
              as Map<String, dynamic>),
      ProductDisplayItem.fromJson(json['market_price'] as Map<String, dynamic>),
      ProductDisplayItem.fromJson(json['discount'] as Map<String, dynamic>),
      ProductDisplayItem.fromJson(
          json['product_promotion_slogan'] as Map<String, dynamic>),
      ProductDisplayItem.fromJson(
          json['promotion_tag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductDisplayToJson(ProductDisplay instance) =>
    <String, dynamic>{
      'sold_out': instance.soldOut,
      'coming_soon': instance.comingSoon,
      'coming_to_an_end': instance.endSoon,
      'promotion_few_left': instance.almostSoldOut,
      'promotion_new': instance.newArrival,
      'promotion_category_purchase_amount_top_10': instance.topSale,
      'promotion_category_collection_amount_top_10': instance.mostWanted,
      'market_price': instance.marketPrice,
      'discount': instance.discount,
      'product_promotion_slogan': instance.productPromotion,
      'promotion_tag': instance.promotionTag,
    };

SearchDisplay _$SearchDisplayFromJson(Map<String, dynamic> json) =>
    SearchDisplay(
      json['is_advanced'] as bool,
      JsonValueConverter.sortOptionsFromString(json['sort_type'] as String),
    );

Map<String, dynamic> _$SearchDisplayToJson(SearchDisplay instance) =>
    <String, dynamic>{
      'is_advanced': instance.advanced,
      'sort_type': JsonValueConverter.sortOptionToString(instance.sort),
    };

FrontPage _$FrontPageFromJson(Map<String, dynamic> json) => FrontPage(
      ProductDisplay.fromJson(json['product_display'] as Map<String, dynamic>),
      SearchDisplay.fromJson(json['search_display'] as Map<String, dynamic>),
      SearchDisplay.fromJson(json['category_display'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FrontPageToJson(FrontPage instance) => <String, dynamic>{
      'product_display': instance.productDisplay,
      'search_display': instance.searchDisplay,
      'category_display': instance.categoryDisplay,
    };
