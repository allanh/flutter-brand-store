// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayoutSetting _$LayoutSettingFromJson(Map<String, dynamic> json) =>
    LayoutSetting(
      IndependentSetting.fromJson(json['setting'] as Map<String, dynamic>),
      Sidebar.fromJson(json['sidebar_mobile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LayoutSettingToJson(LayoutSetting instance) =>
    <String, dynamic>{
      'setting': instance.setting,
      'sidebar_mobile': instance.sidebar,
    };
