import 'package:json_annotation/json_annotation.dart';
import 'category_main.dart';
import 'image_info.dart';
import 'spec_sku.dart';
import 'promotion.dart';
import 'shipped_method.dart';
import 'payment.dart';
import 'tag.dart';
import 'event.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'goods_id')
  String? goodsId;
  @JsonKey(name: 'goods_no')
  String? goodsNo;
  @JsonKey(name: 'goods_status')
  String? goodsStatus;
  String? name;
  @JsonKey(name: 'goods_type')
  String? goodsType;
  @JsonKey(name: 'category_main')
  CategoryMain? categoryMain;
  @JsonKey(name: 'category_sub')
  List<CategoryMain>? categorySub;
  @JsonKey(name: 'image_info')
  List<ImageInfo>? imageInfo;
  @JsonKey(name: 'spec_type')
  String? specType;
  @JsonKey(name: 'specLv1_display')
  String? specLv1Display;
  @JsonKey(name: 'specLv1_title')
  String? specLv1Title;
  @JsonKey(name: 'specLv2_display')
  String? specLv2Display;
  @JsonKey(name: 'specLv2_title')
  String? specLv2Title;
  @JsonKey(name: 'spec_sku')
  List<SpecSku>? specSku;
  @JsonKey(name: 'spec_info1')
  List<SpecSku>? specInfo1;
  @JsonKey(name: 'spec_info2')
  List<SpecSku>? specInfo2;
  @JsonKey(name: 'promotion_app')
  Promotion? promotionApp;
  @JsonKey(name: 'brand_name')
  String? brandName;
  @JsonKey(name: 'country_of_origin')
  String? countryOfOrigin;
  String? material;
  String? model;
  @JsonKey(name: 'unit_name')
  String? unitName;
  @JsonKey(name: 'is_app_only')
  bool? isAppOnly;
  @JsonKey(name: 'is_restricted')
  bool? isRestricted;
  @JsonKey(name: 'is_recycle')
  bool? isRecycle;
  @JsonKey(name: 'is_large')
  bool? isLarge;
  @JsonKey(name: 'shelf_status')
  String? shelfStatus;
  @JsonKey(name: 'started_at')
  String? startedAt;
  @JsonKey(name: 'ended_at')
  String? endedAt;
  @JsonKey(name: 'is_favorite')
  bool? isFavorite;
  @JsonKey(name: 'stock_status')
  String? stockStatus;
  @JsonKey(name: 'shipped_type')
  String? shippedType;
  @JsonKey(name: 'shipped_preorder_date')
  List<String>? shippedPreorderDate;
  @JsonKey(name: 'shipped_custom_day')
  int? shippedCustomDay;
  @JsonKey(name: 'special_description')
  String? specialDescription;
  String? description;
  String? tags;
  String? expiry;
  @JsonKey(name: 'expire_date')
  String? expireDate;
  @JsonKey(name: 'expire_date_type')
  String? expireDateType;
  double? length;
  double? width;
  double? height;
  double? weight;
  @JsonKey(name: 'box_length')
  double? boxLength;
  @JsonKey(name: 'box_width')
  double? boxWidth;
  @JsonKey(name: 'box_height')
  double? boxHeight;
  @JsonKey(name: 'box_weight')
  double? boxWeight;
  @JsonKey(name: 'temperature_layer')
  String? temperatureLayer;
  @JsonKey(name: 'shipped_method')
  List<ShippedMethod>? shippedMethod;
  @JsonKey(name: 'payment_info')
  Payment? paymentInfo;
  @JsonKey(name: 'bonus_bank_info')
  BonusBankInfo? bonusBankInfo;
  @JsonKey(name: 'product_info')
  List<ProductInfo>? productInfo;
  @JsonKey(name: 'recom_list')
  List<Product>? recomList;
  @JsonKey(name: 'freebie_info')
  List<Product>? freebieInfo;
  @JsonKey(name: 'addon_info')
  List<Product>? addonInfo;
  ProductInfo? product;
  @JsonKey(name: 'event_list')
  List<Event>? eventList;
  @JsonKey(name: 'sliding_image')
  List<ImageInfo>? slidingImage;

  // freebie
  @JsonKey(name: 'freebie_buy_num')
  int? freebieBuyNum;
  @JsonKey(name: 'freebie_gift_num')
  int? freebieGiftNum;
  @JsonKey(name: 'freebie_gift_limit_on')
  int? freebieGiftLimitOn;
  @JsonKey(name: 'freebie_gift_limit')
  int? freebieGiftLimit;

  // addon
  @JsonKey(name: 'addon_fixed_price')
  int? addonFixedPrice;

  Product(
      {this.goodsId,
      this.goodsNo,
      this.goodsStatus,
      this.name,
      this.goodsType,
      this.categoryMain,
      this.categorySub,
      this.imageInfo,
      this.specType,
      this.specLv1Display,
      this.specLv1Title,
      this.specLv2Display,
      this.specLv2Title,
      this.specSku,
      this.specInfo1,
      this.specInfo2,
      this.promotionApp,
      this.brandName,
      this.countryOfOrigin,
      this.material,
      this.model,
      this.unitName,
      this.isAppOnly,
      this.isRestricted,
      this.isRecycle,
      this.isLarge,
      this.shelfStatus,
      this.startedAt,
      this.endedAt,
      this.isFavorite,
      this.stockStatus,
      this.shippedType,
      this.shippedPreorderDate,
      this.shippedCustomDay,
      this.specialDescription,
      this.description,
      this.tags,
      this.expiry,
      this.expireDate,
      this.expireDateType,
      this.length,
      this.width,
      this.height,
      this.weight,
      this.boxLength,
      this.boxWidth,
      this.boxHeight,
      this.boxWeight,
      this.temperatureLayer,
      this.shippedMethod,
      this.paymentInfo,
      this.bonusBankInfo,
      this.productInfo,
      this.recomList,
      this.freebieInfo,
      this.addonInfo,
      this.product,
      this.eventList,
      this.slidingImage,
      this.freebieBuyNum,
      this.freebieGiftNum,
      this.freebieGiftLimitOn,
      this.freebieGiftLimit,
      this.addonFixedPrice});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductInfo {
  int? lvl;
  @JsonKey(name: 'store_no')
  String? storeNo;
  @JsonKey(name: 'product_status')
  String? productStatus;
  @JsonKey(name: 'product_id')
  int? productId;
  @JsonKey(name: 'product_no')
  String? productNo;
  @JsonKey(name: 'product_name')
  String? productName;
  @JsonKey(name: 'spec_no')
  String? specNo;
  @JsonKey(name: 'spec_lv_1_id')
  int? specLv1Id;
  @JsonKey(name: 'spec_lv_1_name')
  String? specLv1Name;
  @JsonKey(name: 'spec_lv_2_id')
  int? specLv2Id;
  @JsonKey(name: 'spec_lv_2_name')
  String? specLv2Name;
  String? store;
  int? quantity;
  @JsonKey(name: 'safe_stock')
  int? safeStock;
  @JsonKey(name: 'sale_limit')
  int? saleLimit;
  int? cost;
  @JsonKey(name: 'market_price')
  int? marketPrice;
  @JsonKey(name: 'proposed_price')
  int? proposedPrice;
  @JsonKey(name: 'promotion_price_app')
  int? promotionPriceApp;
  @JsonKey(name: 'url_group_id')
  String? urlGroupId;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'image_info')
  List<ImageInfo>? imageInfo;
  Tag? tagProd;
  Tag? tag;
  StagingInfo? stagePriceBestApp;
  List<StagingInfo>? stagePriceInfoApp;

  ProductInfo(
      {this.lvl,
      this.storeNo,
      this.productStatus,
      this.productId,
      this.productNo,
      this.productName,
      this.specNo,
      this.specLv1Id,
      this.specLv1Name,
      this.specLv2Id,
      this.specLv2Name,
      this.store,
      this.quantity,
      this.safeStock,
      this.saleLimit,
      this.cost,
      this.marketPrice,
      this.proposedPrice,
      this.promotionPriceApp,
      this.urlGroupId,
      this.imageUrl,
      this.imageInfo,
      this.tagProd,
      this.tag,
      this.stagePriceBestApp,
      this.stagePriceInfoApp});

  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ProductInfoToJson(this);
}
