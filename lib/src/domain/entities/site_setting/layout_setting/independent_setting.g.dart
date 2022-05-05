// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'independent_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoItem _$LogoItemFromJson(Map<String, dynamic> json) => LogoItem(
      json['url'] as String,
    );

Map<String, dynamic> _$LogoItemToJson(LogoItem instance) => <String, dynamic>{
      'url': instance.uri,
    };

Logo _$LogoFromJson(Map<String, dynamic> json) => Logo(
      LogoItem.fromJson(json['pc'] as Map<String, dynamic>),
      LogoItem.fromJson(json['mobile_1'] as Map<String, dynamic>),
      LogoItem.fromJson(json['mobile_2'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LogoToJson(Logo instance) => <String, dynamic>{
      'pc': instance.pc,
      'mobile_1': instance.mobile1,
      'mobile_2': instance.mobile2,
    };

IndependentSetting _$IndependentSettingFromJson(Map<String, dynamic> json) =>
    IndependentSetting(
      json['brand_id'] as int,
      json['template_id'] as int,
      json['main_id'] as int,
      json['module_type'] as String,
      json['layout_id'] as int,
      json['max_width'] as int,
      JsonValueConverter.fromHex(json['theme_color'] as String),
      JsonValueConverter.fromHex(json['mem_back_color_value'] as String),
      JsonValueConverter.fromHex(json['focus_color'] as String),
      JsonValueConverter.fromHex(json['border_title_back_color'] as String),
      JsonValueConverter.fromHex(json['title_text_color'] as String),
      JsonValueConverter.boolFromString(json['prod_img_border'] as String?),
      JsonValueConverter.boolFromString(
          json['prod_img_border_radius'] as String?),
      JsonValueConverter.boolFromString(
          json['prod_img_border_shadow'] as String?),
      Logo.fromJson(json['img'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IndependentSettingToJson(IndependentSetting instance) =>
    <String, dynamic>{
      'brand_id': instance.brandId,
      'template_id': instance.templateId,
      'main_id': instance.mainId,
      'module_type': instance.moduleType,
      'layout_id': instance.id,
      'max_width': instance.maxWidth,
      'theme_color': JsonValueConverter.toHex(instance.theme),
      'mem_back_color_value':
          JsonValueConverter.toHex(instance.memberBackground),
      'focus_color': JsonValueConverter.toHex(instance.focus),
      'border_title_back_color':
          JsonValueConverter.toHex(instance.borderTitleBackground),
      'title_text_color': JsonValueConverter.toHex(instance.title),
      'prod_img_border':
          JsonValueConverter.boolToString(instance.productImageBorder),
      'prod_img_border_radius':
          JsonValueConverter.boolToString(instance.productImageBorderRadius),
      'prod_img_border_shadow':
          JsonValueConverter.boolToString(instance.productImageBorderShadow),
      'img': instance.logo,
    };
