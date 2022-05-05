// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerItem _$CustomerItemFromJson(Map<String, dynamic> json) => CustomerItem(
      json['is_enable'] as bool,
    );

Map<String, dynamic> _$CustomerItemToJson(CustomerItem instance) =>
    <String, dynamic>{
      'is_enable': instance.enabled,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      CustomerItem.fromJson(json['visitor_buy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'visitor_buy': instance.visitorBuy,
    };
