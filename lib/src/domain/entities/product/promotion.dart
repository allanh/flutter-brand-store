import 'package:json_annotation/json_annotation.dart';
part 'promotion.g.dart';

/// 特惠適⽤裝置
enum PromotionDevice {
  @JsonValue('WEB')
  web, // 網⾴
  @JsonValue('APP')
  app, // ⼿機
}

/// 特惠折扣⽅式
enum PromotionType {
  @JsonValue('RATE')
  text, // 折數
  @JsonValue('MONEY')
  picture, // 元
}

@JsonSerializable()
class Promotion {
  @JsonKey(name: 'promotion_device')
  PromotionDevice? device;
  @JsonKey(name: 'promotion_type')
  PromotionType? type;
  @JsonKey(name: 'promotion_rate')
  int? rate;
  @JsonKey(name: 'promotion_price')
  int? price;
  @JsonKey(name: 'promotion_slogan')
  String? slogan;
  @JsonKey(name: 'promotion_price_started_at')
  String? priceStartedAt;
  @JsonKey(name: 'promotion_price_ended_at')
  String? priceEndedAt;

  Promotion(
      {this.device,
      this.type,
      this.rate,
      this.price,
      this.slogan,
      this.priceStartedAt,
      this.priceEndedAt});

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);
  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}
