import 'package:json_annotation/json_annotation.dart';
part 'promotion.g.dart';

@JsonSerializable()
class Promotion {
  @JsonKey(name: 'promotion_device')
  String? device;
  @JsonKey(name: 'promotion_type')
  String? type;
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
