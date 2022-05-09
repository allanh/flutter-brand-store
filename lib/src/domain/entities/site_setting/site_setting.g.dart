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
      StoreSetting.fromJson(json['store_setting'] as Map<String, dynamic>),
      LayoutSetting.fromJson(json['layout_setting'] as Map<String, dynamic>),
      MenuSetting.fromJson(json['menu_setting'] as Map<String, dynamic>),
      json['new_event_title'] == null
          ? null
          : EventListItem.fromJson(
              json['new_event_title'] as Map<String, dynamic>),
      (json['new_event_list'] as List<dynamic>?)
              ?.map((e) => EventListItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SiteSettingToJson(SiteSetting instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'anonkey': instance.annonmousKey,
      'site': instance.status,
      'store_setting': instance.store,
      'layout_setting': instance.layout,
      'menu_setting': instance.menu,
      'new_event_title': instance.listTitle,
      'new_event_list': instance.listItems,
    };
