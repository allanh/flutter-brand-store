import 'package:brandstores/src/app/utils/constants.dart';
import 'package:collection/collection.dart';
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
import 'package:brandstores/src/extension/string_extension.dart';
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
  @JsonKey(name: 'image_url')
  String? imageUrl;

  // addon
  @JsonKey(name: 'addon_fixed_price')
  int? addonFixedPrice;
  final DateFormat _inputDateFormat = DateFormat(originalFullDateFormat);

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

  /// 非空值的圖片或影片列表
  List<MyPlusImageInfo>? get mediaList =>
      imageInfo?.where((element) => element.url?.isNotEmpty == true).toList();

  /// 只有圖片列表
  List<MyPlusImageInfo>? get imageList =>
      mediaList?.where((element) => element.type == ImageType.image).toList();

  /// 折數
  double? get discountRate =>
      (promotionApp?.type == PromotionType.rate) ? promotionApp?.rate : null;

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

  /// 最小網路價
  int? get minProposedPrice =>
      productInfo?.map((element) => element.proposedPrice).min;

  /// 是否為多價格
  bool get isRangePrice =>
      productInfo
          ?.any((element) => element.proposedPrice != minProposedPrice) ??
      false;

  /// default specification text
  String getDefaultSpecText(String? preorderDate) {
    final buffer = StringBuffer();
    buffer.write('請選擇 ');

    if (ShippedType.preorder == shippedType && preorderDate == null) {
      buffer.write('出貨日期/');
    }
    if (specLv1Title?.isNotEmpty == true) {
      buffer.write('$specLv1Title/');
    }
    if (specLv2Title?.isNotEmpty == true) {
      buffer.write('$specLv2Title/');
    }
    buffer.write('數量');
    return buffer.toString();
  }

  /**
     * 請選擇 出貨日期/尺寸/顏色/數量
     * 已選 M, 深黑色, 1 件
     ** /
    getSelectedSpecText(specName1: String?, specName2: String?, count: Int? = 0): SpannableStringBuilder? =
        SpannableStringBuilder(getString(R.string.product_chose_text)).append(" ")
            .apply {
                specName1?.takeIf { it.isNotEmpty() }?.let { append("$it, ") }
                specName2?.takeIf { it.isNotEmpty() }?.let { append("$it, ") }
                append(getString(R.string.product_quantity_format, count))
                val countIndex = lastIndexOf(count.toString())
                setSpan(ForegroundColorSpan(Color.RED), countIndex, countIndex + count.toString().length, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE)
            }
            */

  /// 規格：『訂製、預購、客約』出貨日期備註
  String? getShippedNote(String? preorderDate) {
    switch (shippedType) {
      case ShippedType.custom:
        return '此商品於付款完成後 $shippedCustomDay 天開始陸續出貨';
      case ShippedType.preorder:
        return preorderDate?.isNotEmpty == true
            ? '預計 ${preorderDate?.convertDateFormat(serverDateFormat, shortDateFormat)} 出貨'
            : null;
      case ShippedType.contact:
        return '因商品屬性，將有專人與您約定送貨日期';
      default:
        return null;
    }
  }

  // 贈品是否已贈完
  bool get freebieisEmpty => freebieGiftLimitOn == 1 && freebieGiftLimit == 0;

  // 保存期限字串
  String? get expiryString => (expiry != null)
      ? (expiry == Expiry.ever ? '永久' : '$expireDate$expireDateType')
      : null;

  // 取得規格商品
  ProductInfo? getProudctInfo(int? productId) => productId != null
      ? productInfo?.firstWhereOrNull((info) => info.productId == productId)
      : null;

  // 取得第一個可銷售的商品
  ProductInfo? getFirstAvaliabedProudctInfo() =>
      productInfo?.firstWhereOrNull((info) => (info.quantity ?? 0) > 0);

  // 取得已選規格的參數, 若無 productId 會取 productInfo 第一個可銷售的商品
  AddToCartParams getAddToCartParams(int? productId) => AddToCartParams(
      no: no,
      productId: productId,
      selectedProductInfo:
          getProudctInfo(productId ?? productInfo?.first.productId) ??
              getFirstAvaliabedProudctInfo());
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

  // App獨享價價差
  int? get promotionPriceAppDiff =>
      ((promotionPriceApp ?? 0) > 0) && proposedPrice != null
          ? proposedPrice! - promotionPriceApp!
          : null;
}

/// 加入購物車
@JsonSerializable()
class AddToCartParams {
  @JsonKey(name: 'goods_no')
  String? no;
  @JsonKey(name: 'product_id')
  int? productId;
  @JsonKey(name: 'qty')
  int? quantity;
  @JsonKey(name: 'delivery_date')
  String? deliveryDate;
  @JsonKey(name: 'addon')
  List<AddToCartParams>? addon;

  // 加購品價格
  int? addonPrice;
  // productId 對應的 ProductInfo
  ProductInfo? selectedProductInfo;

  AddToCartParams({
    this.no,
    this.productId,
    this.quantity,
    this.deliveryDate,
    this.addon,
    this.addonPrice,
    this.selectedProductInfo,
  });

  factory AddToCartParams.fromJson(Map<String, dynamic> json) =>
      _$AddToCartParamsFromJson(json);
  Map<String, dynamic> toJson() => _$AddToCartParamsToJson(this);
}

/// 測試用
extension MockProduct on Product {
  List<Event> get mockEvents => [
        Event(
            eventOnline: true,
            type: EventType.eventDiscount,
            ruleType: RuleType.noRules,
            ruleContent: RuleContent.productDiscount,
            ruleInfos: [
              RuleInfos(ruleInfo: [RuleInfo(discount: 1000)])
            ]),
        Event(
            eventOnline: false,
            type: EventType.eventDiscount,
            ruleType: RuleType.fillUp,
            ruleContent: RuleContent.productPercentOff,
            ruleInfos: [
              RuleInfos(ruleInfo: [RuleInfo(perUnit: 3, discount: 7)])
            ]),
      ];

  List<Product> get mockAddons =>
      [this, this, this, this..addonFixedPrice = 999999];

  // 廣告
  String get mockAd =>
      'https://storage.googleapis.com/udi_upload/202203223836db79199b4c2db32c099b4763c482';

  // 鑑賞期
  String? get orderHesitate => '7天';
}
