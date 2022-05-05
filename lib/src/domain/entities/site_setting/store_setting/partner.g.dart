// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Partner _$PartnerFromJson(Map<String, dynamic> json) => Partner(
      DateTime.parse(json['begin_date'] as String),
    );

Map<String, dynamic> _$PartnerToJson(Partner instance) => <String, dynamic>{
      'begin_date': instance.beginDate.toIso8601String(),
    };
