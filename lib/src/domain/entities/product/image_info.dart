import 'package:json_annotation/json_annotation.dart';
part 'image_info.g.dart';

@JsonSerializable()
class ImageInfo {
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'coupon_id')
  String? couponId;
  String? type;
  String? url;

  ImageInfo({this.imageUrl, this.couponId, this.type, this.url});

  factory ImageInfo.fromJson(Map<String, dynamic> json) =>
      _$ImageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ImageInfoToJson(this);
}
