// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteStatus _$SiteStatusFromJson(Map<String, dynamic> json) => SiteStatus(
      json['coming_soon'] as bool,
      json['name'] as String,
      json['host'] as String,
      json['re_captcha_site_key'] as String,
    );

Map<String, dynamic> _$SiteStatusToJson(SiteStatus instance) =>
    <String, dynamic>{
      'coming_soon': instance.commingSoon,
      'name': instance.name,
      'host': instance.host,
      're_captcha_site_key': instance.captchaKey,
    };

SiteSetting _$SiteSettingFromJson(Map<String, dynamic> json) => SiteSetting(
      DateTime.parse(json['date'] as String),
      json['anonkey'] as String,
      SiteStatus.fromJson(json['site'] as Map<String, dynamic>),
      LayoutSetting.fromJson(json['layout_setting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SiteSettingToJson(SiteSetting instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'anonkey': instance.annonmousKey,
      'site': instance.status,
      'layout_setting': instance.layout,
    };

SiteSettingResponse _$SiteSettingResponseFromJson(Map<String, dynamic> json) =>
    SiteSettingResponse(
      SiteSetting.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..id = json['id'] as String
      ..message = json['message'] as String?
      ..status = $enumDecode(_$ResponseStatusEnumMap, json['status']);

Map<String, dynamic> _$SiteSettingResponseToJson(
        SiteSettingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'status': _$ResponseStatusEnumMap[instance.status],
      'data': instance.setting,
    };

const _$ResponseStatusEnumMap = {
  ResponseStatus.success: 'SUCCESS',
  ResponseStatus.failure: 'FAILURE',
};
