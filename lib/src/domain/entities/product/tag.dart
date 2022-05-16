import 'package:json_annotation/json_annotation.dart';
part 'tag.g.dart';

@JsonSerializable()
class Tag {
  // tag_prod

  bool? video;
  @JsonKey(name: 'coming_soon')
  bool? comingSoon;
  @JsonKey(name: 'flash_sale')
  bool? flashSale;
  bool? favorite;
  @JsonKey(name: 'sold_out')
  bool? soldOut;
  @JsonKey(name: 'isnew')
  bool? isNew;
  @JsonKey(name: 'istop10_sale')
  bool? istop10Sale;
  @JsonKey(name: 'istop10_favorite')
  bool? istop10Favorite;

  // tag
  bool? freebie;
  bool? preorder;
  bool? custom;
  bool? contact;
  @JsonKey(name: 'temperature_freeze')
  bool? temperatureFreeze;
  @JsonKey(name: 'app_only')
  bool? appOnly;
  @JsonKey(name: 'low_quantity')
  bool? lowQuantity;
  bool? recycle;
  bool? restricted;

  Tag(
      {this.video,
      this.comingSoon,
      this.flashSale,
      this.favorite,
      this.soldOut,
      this.isNew,
      this.istop10Sale,
      this.istop10Favorite,
      this.freebie,
      this.preorder,
      this.custom,
      this.contact,
      this.temperatureFreeze,
      this.appOnly,
      this.lowQuantity,
      this.recycle,
      this.restricted});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}
