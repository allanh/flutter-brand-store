import 'package:json_annotation/json_annotation.dart';

import '../../../../data/helper/json_value_converter.dart';

import '../../sort_option.dart';

part 'front_page.g.dart';

// FrontPage
enum Page {
  @JsonValue('HOME') home,
  @JsonValue('CATEGORY') category,
  @JsonValue('SEARCH') search,
  @JsonValue('PRODUCT') product,
}
enum DiscountFormat {
  @JsonValue('CHINESE') chinese,
  @JsonValue('PERCENTAGE') percentage
}
@JsonSerializable()
class ProductDisplayItem {
  ProductDisplayItem(this.slogan, this.pages, this.quantity);
  static ProductDisplayItem get empty {
    return ProductDisplayItem(null, [], null);
  }

  final String? slogan;
  @JsonKey(name: 'page')
  final List<Page> pages;
  final String? quantity;
  DiscountFormat? format;

  factory ProductDisplayItem.fromJson(Map<String, dynamic> json) => _$ProductDisplayItemFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDisplayItemToJson(this);
}
@JsonSerializable()
class ProductDisplay {
  ProductDisplay(this.soldOut, this.comingSoon, this.endSoon, this.almostSoldOut, this.newArrival, this.topSale, this.mostWanted, this.marketPrice, this.discount, this.productPromotion, this.promotionTag);
  static ProductDisplay get empty {
    return ProductDisplay(
      ProductDisplayItem.empty, 
      ProductDisplayItem.empty, 
      ProductDisplayItem.empty, 
      ProductDisplayItem.empty, 
      ProductDisplayItem.empty, 
      ProductDisplayItem.empty, 
      ProductDisplayItem.empty, 
      ProductDisplayItem.empty, 
      ProductDisplayItem.empty, 
      ProductDisplayItem.empty, 
      ProductDisplayItem.empty
    );
  }

  @JsonKey(name: 'sold_out')
  final ProductDisplayItem soldOut;
  @JsonKey(name: 'coming_soon')
  final ProductDisplayItem comingSoon;
  @JsonKey(name: 'coming_to_an_end')
  final ProductDisplayItem endSoon;
  @JsonKey(name: 'promotion_few_left')
  final ProductDisplayItem almostSoldOut;
  @JsonKey(name: 'promotion_new')
  final ProductDisplayItem newArrival;
  @JsonKey(name: 'promotion_category_purchase_amount_top_10')
  final ProductDisplayItem topSale;
  @JsonKey(name: 'promotion_category_collection_amount_top_10')
  final ProductDisplayItem mostWanted;
  @JsonKey(name: 'market_price')
  final ProductDisplayItem marketPrice;
  final ProductDisplayItem discount;
  @JsonKey(name: 'product_promotion_slogan')
  final ProductDisplayItem productPromotion;
  @JsonKey(name: 'promotion_tag')
  final ProductDisplayItem promotionTag;

  factory ProductDisplay.fromJson(Map<String, dynamic> json) => _$ProductDisplayFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDisplayToJson(this);
}
@JsonSerializable()
class SearchDisplay {
  SearchDisplay(this.advanced, this.sort);
  static SearchDisplay get empty {
    return SearchDisplay(false, SortOptions.hot);
  }

  @JsonKey(name: 'is_advanced')
  final bool advanced;
  @JsonKey(name: 'sort_type', fromJson: JsonValueConverter.sortOptionsFromString, toJson: JsonValueConverter.sortOptionToString)
  final SortOptions sort;

  factory SearchDisplay.fromJson(Map<String, dynamic> json) => _$SearchDisplayFromJson(json);
  Map<String, dynamic> toJson() => _$SearchDisplayToJson(this);
}
@JsonSerializable()
class FrontPage {
  FrontPage(this.productDisplay, this.searchDisplay, this.categoryDisplay);
  static FrontPage get empty {
    return FrontPage(ProductDisplay.empty, SearchDisplay.empty, SearchDisplay.empty);
  }

  @JsonKey(name: 'product_display')
  final ProductDisplay productDisplay;
  @JsonKey(name: 'search_display')
  final SearchDisplay searchDisplay;
  @JsonKey(name: 'category_display')
  final SearchDisplay categoryDisplay;

  factory FrontPage.fromJson(Map<String, dynamic> json) => _$FrontPageFromJson(json);
  Map<String, dynamic> toJson() => _$FrontPageToJson(this);
}
