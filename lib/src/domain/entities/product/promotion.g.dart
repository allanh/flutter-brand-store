// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      device: json['promotion_device'] as String?,
      type: json['promotion_type'] as String?,
      rate: json['promotion_rate'] as int?,
      price: json['promotion_price'] as int?,
      slogan: json['promotion_slogan'] as String?,
      priceStartedAt: json['promotion_price_started_at'] as String?,
      priceEndedAt: json['promotion_price_ended_at'] as String?,
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'promotion_device': instance.device,
      'promotion_type': instance.type,
      'promotion_rate': instance.rate,
      'promotion_price': instance.price,
      'promotion_slogan': instance.slogan,
      'promotion_price_started_at': instance.priceStartedAt,
      'promotion_price_ended_at': instance.priceEndedAt,
    };
