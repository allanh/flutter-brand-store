import 'package:json_annotation/json_annotation.dart';
part 'spec_sku.g.dart';

/// 商品規格種類
enum SpecType {
  @JsonValue('NONE')
  none, // 無規
  @JsonValue('SINGLE')
  single, // 單規
  @JsonValue('DOUBLE')
  double, // 雙規
}

/// 前台顯⽰
enum SpecDisplay {
  @JsonValue('TEXT')
  text, // 無規
  @JsonValue('PICTURE')
  picture, // 單規
  @JsonValue('TEXT_PICTURE')
  textPicture, // 雙規
}

@JsonSerializable()
class SpecSku {
  int? level;
  @JsonKey(name: 'spec_name')
  String? specName;
  @JsonKey(name: 'image_url')
  String? imageUrl;

  // 規格等級一
  @JsonKey(name: 'spec_lv_1_id')
  int? specLv1Id;
  @JsonKey(name: 'spec_lv_1_name')
  String? specLv1Name;
  @JsonKey(name: 'spec_image_url')
  String? specImageUrl;
  Sku? sku;

  // 規格等級二
  @JsonKey(name: 'spec_2')
  List<SpecSku>? spec2;
  @JsonKey(name: 'spec_lv_2_id')
  int? specLv2Id;
  @JsonKey(name: 'spec_lv_2_name')
  String? specLv2Name;
  @JsonKey(name: 'is_product')
  bool? isProduct;

  SpecSku(
      {this.level,
      this.specName,
      this.imageUrl,
      this.specLv1Id,
      this.specLv1Name,
      this.specImageUrl,
      this.sku,
      this.spec2,
      this.specLv2Id,
      this.specLv2Name,
      this.isProduct});

  factory SpecSku.fromJson(Map<String, dynamic> json) =>
      _$SpecSkuFromJson(json);
  Map<String, dynamic> toJson() => _$SpecSkuToJson(this);
}

@JsonSerializable()
class Sku {
  @JsonKey(name: 'product_id')
  int? productId;
  @JsonKey(name: 'product_no')
  String? productNo;
  @JsonKey(name: ' product_name')
  String? productName;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  int? quantity;
  @JsonKey(name: 'sale_limit')
  int? saleLimit;
  @JsonKey(name: 'proposed_price')
  int? proposedPrice;

  Sku(
      {this.productId,
      this.productNo,
      this.productName,
      this.imageUrl,
      this.quantity,
      this.saleLimit,
      this.proposedPrice});

  factory Sku.fromJson(Map<String, dynamic> json) => _$SkuFromJson(json);
  Map<String, dynamic> toJson() => _$SkuToJson(this);
}
