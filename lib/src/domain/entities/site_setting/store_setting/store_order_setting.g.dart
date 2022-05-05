// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_order_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreOrderSetting _$StoreOrderSettingFromJson(Map<String, dynamic> json) =>
    StoreOrderSetting(
      json['partial_return'] as bool,
      json['order_hesitate'] as int,
    );

Map<String, dynamic> _$StoreOrderSettingToJson(StoreOrderSetting instance) =>
    <String, dynamic>{
      'partial_return': instance.partialReturn,
      'order_hesitate': instance.hesitate,
    };
