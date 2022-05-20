import 'package:brandstores/src/app/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'category_main.dart';
import 'image_info.dart';
import 'spec_sku.dart';
import 'promotion.dart';
import 'shipped_method.dart';
import 'payment.dart';
import 'tag.dart';
import 'event.dart';
import '../status.dart';
import '../../../extension/iterable_extension.dart';
part 'product.g.dart';

/// 商品狀態
enum ProductStatus {
  @JsonValue('COMING_SOON')
  comingSoon, // 即將開賣
  @JsonValue('SOLD_OUT')
  soldOut, // 已售完/已停售
  @JsonValue('SOLD_END')
  soldEnd, // 銷售結束
  @JsonValue('APP_ONLY')
  appOnly, // APP獨賣品
  @JsonValue('BUYABLE')
  buyable, // 立即購買
}

/// 商品類型
enum ProductType {
  @JsonValue('MAIN')
  main, // 普通
  @JsonValue('ADDON')
  addon, // 加購品
  @JsonValue('FREEBIE')
  freebie, // 贈品
}

/// 上架狀態
enum ShelfStatus {
  @JsonValue('ON_SHELF')
  onShelf, // 上架
  @JsonValue('OFF_SHELF')
  offShelf, // 下架
  @JsonValue('DRAFT')
  draft, // 暫存未上架
}

/// 庫存狀態
enum StockStatus {
  @JsonValue('HIGH_STOCK')
  highStock, // 可銷量⾼
  @JsonValue('LOW_STOCK')
  lowStock, // 可銷量低
  @JsonValue('PARTIAL_ZERO_STOCK')
  partialZeroStock, // 部份已售完
  @JsonValue('ZERO_STOCK')
  zeroStock, // 已售完
}

/// 上架狀態
enum Store {
  @JsonValue('BRAND')
  brand, // 品牌
  @JsonValue('MOMO')
  momo, // MOMO
  @JsonValue('SHOPEE')
  shopee, // 蝦⽪
}

@JsonSerializable()
class Product {
  @JsonKey(name: 'goods_no')
  String? no;
  @JsonKey(name: 'goods_status')
  ProductStatus? status;
  String? name;
  @JsonKey(name: 'goods_type')
  ProductType? type;
  @JsonKey(name: 'category_main')
  CategoryMain? categoryMain;
  @JsonKey(name: 'category_sub')
  List<CategoryMain>? categorySub;
  @JsonKey(name: 'image_info')
  List<MyPlusImageInfo>? imageInfo;
  @JsonKey(name: 'spec_type')
  SpecType? specType;
  @JsonKey(name: 'spec_lv_1_display')
  SpecDisplay? specLv1Display;
  @JsonKey(name: 'spec_lv_1_title')
  String? specLv1Title;
  @JsonKey(name: 'spec_lv_2_display')
  SpecDisplay? specLv2Display;
  @JsonKey(name: 'spec_lv_2_title')
  String? specLv2Title;
  @JsonKey(name: 'spec_sku')
  List<SpecSku>? specSku;
  @JsonKey(name: 'spec_info_1')
  List<SpecSku>? specInfo1;
  @JsonKey(name: 'spec_info_2')
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
  ShelfStatus? shelfStatus;
  @JsonKey(name: 'started_at')
  String? startedAt;
  @JsonKey(name: 'ended_at')
  String? endedAt;
  @JsonKey(name: 'is_favorite')
  bool? isFavorite;
  @JsonKey(name: 'stock_status')
  StockStatus? stockStatus;
  @JsonKey(name: 'shipped_type')
  ShippedType? shippedType;
  @JsonKey(name: 'shipped_preorder_date')
  List<String>? shippedPreorderDate;
  @JsonKey(name: 'shipped_custom_day')
  int? shippedCustomDay;
  @JsonKey(name: 'special_description')
  String? specialDescription;
  String? description;
  String? tags;
  Expiry? expiry;
  @JsonKey(name: 'expire_date')
  int? expireDate;
  @JsonKey(name: 'expire_date_type')
  ExpireDateType? expireDateType;
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
  TemperatureLayer? temperatureLayer;
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
  ProductInfo? product; // 已選規格品
  @JsonKey(name: 'event_list')
  List<Event>? eventList;
  @JsonKey(name: 'sliding_image')
  List<MyPlusImageInfo>? slidingImage;

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
  DateFormat _inputDateFormat = DateFormat(inputFormat);

  Product(
      {this.no,
      this.status,
      this.name,
      this.type,
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

  /// 圖片列表
  List<String>? get imageList => imageInfo
      ?.where(
          (element) => element.url != null && element.type == ImageType.image)
      .map((element) => element.url!)
      .toList();

  /// 倒數時間
  Duration? get countdownDuration {
    if (productInfo?.isEmpty == true) return null;

    final now = DateTime.now();
    // 測試用
    // return now.add(const Duration(days: 2)).difference(now);
    // 即將開賣時間
    if (productInfo!.first.tagProd?.comingSoon == true && startedAt != null) {
      return _inputDateFormat.parse(startedAt!).difference(now);
      // 限時搶購時間
    } else if (productInfo!.first.tagProd?.flashSale == true &&
        promotionApp?.priceEndedAt != null) {
      return _inputDateFormat
          .parse(promotionApp!.priceEndedAt!)
          .difference(now);
    }
    return null;
  }

  // 最小網路價
  int? get minProposedPrice =>
      productInfo?.map((element) => element.proposedPrice).min;

  // 是否為多價格
  bool get isRangePrice =>
      productInfo
          ?.any((element) => element.proposedPrice != minProposedPrice) ??
      false;
}

@JsonSerializable()
class ProductInfo {
  int? lvl;
  @JsonKey(name: 'store_no')
  String? storeNo;
  @JsonKey(name: 'product_status')
  EnabledStatus? productStatus;
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
  Store? store;
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
  List<MyPlusImageInfo>? imageInfo;
  @JsonKey(name: 'tag_prod')
  Tag? tagProd;
  Tag? tag;
  @JsonKey(name: 'stage_price_best_app')
  StagingInfo? stagePriceBestApp;
  @JsonKey(name: 'stage_price_info_app')
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
