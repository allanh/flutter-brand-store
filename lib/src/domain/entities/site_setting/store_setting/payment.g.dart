// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StagingInfo _$StagingInfoFromJson(Map<String, dynamic> json) => StagingInfo(
      json['stage'] as int,
      (json['interest'] as num).toDouble(),
      json['is_default_product_use'] as bool,
      json['is_enable'] as bool,
      json['key'] as String,
    );

Map<String, dynamic> _$StagingInfoToJson(StagingInfo instance) =>
    <String, dynamic>{
      'stage': instance.stage,
      'interest': instance.interest,
      'is_default_product_use': instance.defaultUsing,
      'is_enable': instance.enabled,
      'key': instance.key,
    };

PaymentItem _$PaymentItemFromJson(Map<String, dynamic> json) => PaymentItem(
      json['is_enable'] as bool,
      json['is_default_product_use'] as bool,
      json['display_name'] as String?,
      json['is_bonus'] as bool?,
      (json['staging_info'] as List<dynamic>?)
          ?.map((e) => StagingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentItemToJson(PaymentItem instance) =>
    <String, dynamic>{
      'is_enable': instance.enabled,
      'is_default_product_use': instance.defaultUsing,
      'display_name': instance.title,
      'is_bonus': instance.bonusEnabled,
      'staging_info': instance.staging,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      PaymentItem.fromJson(json['credit'] as Map<String, dynamic>),
      PaymentItem.fromJson(json['atm'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'credit': instance.credit,
      'atm': instance.atm,
    };
