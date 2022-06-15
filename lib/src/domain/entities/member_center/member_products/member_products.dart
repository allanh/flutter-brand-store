import 'package:brandstores/src/domain/entities/product/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_products.g.dart';

@JsonSerializable()
class MemberProductsResponse {
  final String id;
  final String status;
  final String? message;

  @JsonKey(name: 'data')
  final MemberProductsInfo memberProducts;

  const MemberProductsResponse(
      this.id, this.status, this.message, this.memberProducts);

  factory MemberProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberProductsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MemberProductsResponseToJson(this);
}

@JsonSerializable()
class MemberProductsInfo {
  final int? total;

  @JsonKey(name: 'current_page')
  int? currentPage;

  @JsonKey(name: 'total_page')
  final int? totalPage;

  final int? limit;

  @JsonKey(name: 'detail')
  final List<MemberProduct> products;

  MemberProductsInfo(
      this.total, this.currentPage, this.totalPage, this.limit, this.products);

  factory MemberProductsInfo.fromJson(Map<String, dynamic> json) =>
      _$MemberProductsInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MemberProductsInfoToJson(this);
}

enum GoodsStatus {
  /// OFFLINE:已下架
  @JsonValue('OFFLINE')
  offline,

  /// COMING_SOON:即將開賣
  @JsonValue('COMING_SOON')
  comingSoon,

  /// SOLD_OUT:已售完
  @JsonValue('SOLD_OUT')
  soldOut,

  /// SOLD_END:銷售結束
  @JsonValue('SOLD_END')
  end,

  /// APP_ONLY:APP獨賣品
  @JsonValue('APP_ONLY')
  exclusive,

  @JsonValue('BUYABLE')
  sale
}

extension GoodsStatusExtension on GoodsStatus {
  String get value {
    switch (this) {
      case GoodsStatus.offline:
        return '已下架';
      case GoodsStatus.comingSoon:
        return '即將開賣';
      case GoodsStatus.soldOut:
        return '已售完';
      case GoodsStatus.end:
        return '銷售結束';
      case GoodsStatus.exclusive:
        return 'APP獨賣品';
      case GoodsStatus.sale:
        return '販售中';
    }
  }
}

enum SpecificationType {
  /// NONE:無規
  @JsonValue('NONE')
  none,

  /// SINGLE:單規
  @JsonValue('SINGLE')
  single,

  /// DOUBLE:雙規
  @JsonValue('DOUBLE')
  double
}

@JsonSerializable()
class MemberProduct {
  MemberProduct(
    this.maxPrice,
    this.minPrice,
    this.imageUrl,
    this.id,
    this.name,
    this.saleDate,
    this.status,
    this.specType,
    this.level1DescribeType,
    this.level1Title,
    this.level2DescribeType,
    this.level2Title,
    this.specifications,
    this.productInfos,
    this.unit,
    this.level1SpecInfo,
    this.level2SpecInfo,
    this.isFavorite,
    this.isOnlineEvent,
    this.isLowStock,
    this.isLowerPrice,
    this.isNewest,
    this.reviewId,
    this.collectionDate,
  );

  @JsonKey(name: 'max_price')
  int? maxPrice;

  @JsonKey(name: 'min_price')
  int? minPrice;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  /// 賣場編號
  @JsonKey(name: 'goods_no')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  /// 購買日期
  @JsonKey(name: 'created_at')
  String? saleDate;

  @JsonKey(name: 'goods_status')
  GoodsStatus? status;

  /// 商品規格種類
  @JsonKey(name: 'spec_type')
  SpecificationType? specType;

  /// 一階規格展示方式
  @JsonKey(name: 'spec_lv_1_display')
  SpecificationDescribeType? level1DescribeType;

  /// 一階規格抬頭名稱
  @JsonKey(name: 'spec_lv_1_title')
  String? level1Title;

  /// 二階規格展示方式
  @JsonKey(name: 'spec_lv_2_display')
  SpecificationDescribeType? level2DescribeType;

  /// 二階規格抬頭名稱
  @JsonKey(name: 'spec_lv_2_title')
  String? level2Title;

  /// 商品sku表
  @JsonKey(name: 'spec_sku')
  List<Specification>? specifications;

  @JsonKey(name: 'product_info')
  List<ProductInfo>? productInfos;

  /// 商品單位
  @JsonKey(name: 'unit_name')
  String? unit;

  @JsonKey(name: 'spec_info_1')
  List<Level1SpecInfo?>? level1SpecInfo;

  @JsonKey(name: 'spec_info_2')
  List<Level2SpecInfo?>? level2SpecInfo;

  @JsonKey(name: 'is_favorite')
  bool? isFavorite;

  /// 是否活動中
  @JsonKey(name: 'under_event')
  bool? isOnlineEvent;

  /// 是否即將售完
  @JsonKey(name: 'low_stock')
  bool? isLowStock;

  /// 是否降價
  @JsonKey(name: 'lower_price')
  bool? isLowerPrice;

  /// 是否新開賣
  @JsonKey(name: 'new_goods')
  bool? isNewest;

  /// 瀏覽id
  @JsonKey(name: 'recent_view_id')
  String? reviewId;

  /// 收藏時間
  @JsonKey(name: 'favorite_at')
  String? collectionDate;

  @JsonKey(name: 'sale_limit_max')
  int? saleLimit;

  factory MemberProduct.fromJson(Map<String, dynamic> json) =>
      _$MemberProductFromJson(json);
  Map<String, dynamic> toJson() => _$MemberProductToJson(this);
}

/// 規格展示方式
enum SpecificationDescribeType {
  /// TEXT:文字
  @JsonValue('TEXT')
  text,

  /// PICTURE:圖片
  @JsonValue('PICTURE')
  picture,

  /// TEXT_PICTURE:圖片加文字
  @JsonValue('TEXT_PICTURE')
  mix,
}

@JsonSerializable()
class Specification {
  Specification(
    this.level,
    this.describeType,
    this.title,
    this.id,
    this.imageUrl,
    this.sku,
    this.level2Sku,
  );

  /// 階層等級
  int? level;

  /// 規格展示方式
  SpecificationDescribeType? describeType;

  /// 一階規格名稱
  @JsonKey(name: 'spec_lv_1_name')
  String? title;

  /// 一階規格ID
  @JsonKey(name: 'spec_lv_1_id')
  int? id;

  /// 一階規格小圖
  @JsonKey(name: 'spec_image_url')
  String? imageUrl;

  /// 一階sku(單規才有這個值)
  @JsonKey(name: 'sku')
  SKU? sku;

  @JsonKey(name: 'spec_2')
  List<Level2SKU?>? level2Sku;

  factory Specification.fromJson(Map<String, dynamic> json) =>
      _$SpecificationFromJson(json);
  Map<String, dynamic> toJson() => _$SpecificationToJson(this);
}

@JsonSerializable()
class SKU {
  SKU(
    this.id,
    this.no,
    this.name,
    this.imageUrl,
    this.price,
    this.limit,
    this.quantity,
  );

  /// 產品規格ID
  @JsonKey(name: 'product_id')
  int? id;

  /// 產品規格編號
  @JsonKey(name: 'product_no')
  String? no;

  @JsonKey(name: 'product_name')
  String? name;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  /// 建議售價
  @JsonKey(name: 'proposed_price')
  int? price;

  /// 銷售數量上限
  @JsonKey(name: 'sale_limit')
  int? limit;

  /// 庫存可銷售量
  @JsonKey(name: 'quantity')
  int? quantity;

  factory SKU.fromJson(Map<String, dynamic> json) => _$SKUFromJson(json);
  Map<String, dynamic> toJson() => _$SKUToJson(this);
}

@JsonSerializable()
class Level2SKU {
  Level2SKU(
    this.level,
    this.title,
    this.id,
    this.imageUrl,
    this.isProduct,
    this.skus,
  );

  /// 階層等級
  int? level;

  /// 二階規格名稱
  @JsonKey(name: 'spec_lv_2_name')
  String? title;

  /// 二階規格ID
  @JsonKey(name: 'spec_lv_2_id')
  int? id;

  /// 二階規格小圖
  @JsonKey(name: 'spec_image_url')
  String? imageUrl;

  /// 是否為產品
  @JsonKey(name: 'is_product')
  bool? isProduct;

  /// 二階sku表
  @JsonKey(name: 'sku')
  SKU? skus;

  factory Level2SKU.fromJson(Map<String, dynamic> json) =>
      _$Level2SKUFromJson(json);
  Map<String, dynamic> toJson() => _$Level2SKUToJson(this);
}

@JsonSerializable()
class Level1SpecInfo {
  Level1SpecInfo(
    this.name,
    this.imageUrl,
    this.sort,
    this.id,
  );

  @JsonKey(name: 'spec_lv_1_id')
  int? id;

  @JsonKey(name: 'spec_name')
  String? name;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  @JsonKey(name: 'spec_sort')
  int? sort;

  factory Level1SpecInfo.fromJson(Map<String, dynamic> json) =>
      _$Level1SpecInfoFromJson(json);
  // @override
  Map<String, dynamic> toJson() => _$Level1SpecInfoToJson(this);
}

@JsonSerializable()
class Level2SpecInfo {
  Level2SpecInfo(
    this.name,
    this.imageUrl,
    this.sort,
    this.id,
  );

  @JsonKey(name: 'spec_lv_2_id')
  int? id;

  @JsonKey(name: 'spec_name')
  String? name;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  @JsonKey(name: 'spec_sort')
  int? sort;

  factory Level2SpecInfo.fromJson(Map<String, dynamic> json) =>
      _$Level2SpecInfoFromJson(json);
  // @override
  Map<String, dynamic> toJson() => _$Level2SpecInfoToJson(this);
}
