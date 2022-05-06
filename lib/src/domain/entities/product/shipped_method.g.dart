// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipped_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippedMethod _$ShippedMethodFromJson(Map<String, dynamic> json) =>
    ShippedMethod(
      type: json['type'] as String?,
      temperatureLayer: json['temperature_layer'] as String?,
      shippingName: json['shipping_name'] as String?,
      displayName: json['display_name'] as String?,
      mainIsEnabled: json['main_is_enabled'] as bool?,
      costType: json['cost_type'] as String?,
      fixedCost: json['fixed_cost'] as int?,
      rangeInfo: json['range_info'] == null
          ? null
          : RangeInfo.fromJson(json['range_info'] as Map<String, dynamic>),
      outlyingIsEnabled: json['outlying_is_enabled'] as bool?,
      outlyingCostType: json['outlying_cost_type'] as String?,
      outlyingFixedCost: json['outlying_fixed_cost'] as int?,
      outlyingRangeInfo: json['outlying_range_info'] as String?,
    );

Map<String, dynamic> _$ShippedMethodToJson(ShippedMethod instance) =>
    <String, dynamic>{
      'type': instance.type,
      'temperature_layer': instance.temperatureLayer,
      'shipping_name': instance.shippingName,
      'display_name': instance.displayName,
      'main_is_enabled': instance.mainIsEnabled,
      'cost_type': instance.costType,
      'fixed_cost': instance.fixedCost,
      'range_info': instance.rangeInfo,
      'outlying_is_enabled': instance.outlyingIsEnabled,
      'outlying_cost_type': instance.outlyingCostType,
      'outlying_fixed_cost': instance.outlyingFixedCost,
      'outlying_range_info': instance.outlyingRangeInfo,
    };
