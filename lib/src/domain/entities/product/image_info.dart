import 'package:json_annotation/json_annotation.dart';
part 'image_info.g.dart';

/// 溫層
enum ImageType {
  @JsonValue('IMAGE')
  image, // 常溫
  @JsonValue('VIDEO')
  video, // 冷藏
}

@JsonSerializable()
class ImageInfo {
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'coupon_id')
  String? couponId;
  ImageType? type;
  String? url;

  ImageInfo({this.imageUrl, this.couponId, this.type, this.url});

  factory ImageInfo.fromJson(Map<String, dynamic> json) =>
      _$ImageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ImageInfoToJson(this);
}
