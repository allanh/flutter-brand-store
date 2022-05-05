// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceSystemInfo _$InvoiceSystemInfoFromJson(Map<String, dynamic> json) =>
    InvoiceSystemInfo(
      json['unified_business_no'] as String,
      json['company_name'] as String,
      json['is_agree'] as bool,
    );

Map<String, dynamic> _$InvoiceSystemInfoToJson(InvoiceSystemInfo instance) =>
    <String, dynamic>{
      'unified_business_no': instance.businessNo,
      'company_name': instance.name,
      'is_agree': instance.agree,
    };

InvoiceInfo _$InvoiceInfoFromJson(Map<String, dynamic> json) => InvoiceInfo(
      $enumDecode(_$InvoiceTypeEnumMap, json['type']),
      json['systemInfo'] == null
          ? null
          : InvoiceSystemInfo.fromJson(
              json['systemInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceInfoToJson(InvoiceInfo instance) =>
    <String, dynamic>{
      'type': _$InvoiceTypeEnumMap[instance.type],
      'systemInfo': instance.systemInfo,
    };

const _$InvoiceTypeEnumMap = {
  InvoiceType.system: 1,
  InvoiceType.self: 2,
  InvoiceType.udi: 3,
};

Charity _$CharityFromJson(Map<String, dynamic> json) => Charity(
      json['charity_id'] as int,
      json['is_enable'] as bool,
      json['display_name'] as String,
      json['code'] as String,
      json['alias_name'] as String,
      json['county'] as String,
      json['key'] as int,
    );

Map<String, dynamic> _$CharityToJson(Charity instance) => <String, dynamic>{
      'charity_id': instance.id,
      'is_enable': instance.enabled,
      'display_name': instance.title,
      'code': instance.code,
      'alias_name': instance.alias,
      'county': instance.county,
      'key': instance.key,
    };

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      InvoiceInfo.fromJson(json['invoice'] as Map<String, dynamic>),
      (json['charity'] as List<dynamic>)
          .map((e) => Charity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'invoice': instance.info,
      'charity': instance.charities,
    };
