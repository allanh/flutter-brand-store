// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      video: json['video'] as bool?,
      comingSoon: json['coming_soon'] as bool?,
      flashSale: json['flash_sale'] as bool?,
      favorite: json['favorite'] as bool?,
      soldOut: json['sold_out'] as bool?,
      isNew: json['isnew'] as bool?,
      istop10Sale: json['istop10_sale'] as bool?,
      istop10Favorite: json['istop10_favorite'] as bool?,
      freebie: json['freebie'] as bool?,
      preorder: json['preorder'] as bool?,
      custom: json['custom'] as bool?,
      contact: json['contact'] as bool?,
      temperatureFreeze: json['temperature_freeze'] as bool?,
      appOnly: json['app_only'] as bool?,
      lowQuantity: json['low_quantity'] as bool?,
      recycle: json['recycle'] as bool?,
      restricted: json['restricted'] as bool?,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'video': instance.video,
      'coming_soon': instance.comingSoon,
      'flash_sale': instance.flashSale,
      'favorite': instance.favorite,
      'sold_out': instance.soldOut,
      'isnew': instance.isNew,
      'istop10_sale': instance.istop10Sale,
      'istop10_favorite': instance.istop10Favorite,
      'freebie': instance.freebie,
      'preorder': instance.preorder,
      'custom': instance.custom,
      'contact': instance.contact,
      'temperature_freeze': instance.temperatureFreeze,
      'app_only': instance.appOnly,
      'low_quantity': instance.lowQuantity,
      'recycle': instance.recycle,
      'restricted': instance.restricted,
    };
