// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageInfo _$ImageInfoFromJson(Map<String, dynamic> json) => ImageInfo(
      imageUrl: json['image_url'] as String?,
      couponId: json['coupon_id'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ImageInfoToJson(ImageInfo instance) => <String, dynamic>{
      'image_url': instance.imageUrl,
      'coupon_id': instance.couponId,
      'type': instance.type,
      'url': instance.url,
    };
