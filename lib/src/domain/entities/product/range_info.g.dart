// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'range_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RangeInfo _$RangeInfoFromJson(Map<String, dynamic> json) => RangeInfo(
      cost: json['cost'] as int?,
      lowerLimit: json['lower_limit'] as int?,
      upperLimit: json['upper_limit'] as int?,
    );

Map<String, dynamic> _$RangeInfoToJson(RangeInfo instance) => <String, dynamic>{
      'cost': instance.cost,
      'lower_limit': instance.lowerLimit,
      'upper_limit': instance.upperLimit,
    };
