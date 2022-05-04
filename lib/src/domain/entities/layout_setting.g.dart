// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SidebarItem _$SidebarItemFromJson(Map<String, dynamic> json) => SidebarItem(
      json['title'] as String,
      $enumDecode(_$LinkTypeEnumMap, json['link']),
      json['link_data'] as String,
      (json['children'] as List<dynamic>)
          .map((e) => SidebarItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SidebarItemToJson(SidebarItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': _$LinkTypeEnumMap[instance.linkType],
      'link_data': instance.linkValue,
      'children': instance.children,
    };

const _$LinkTypeEnumMap = {
  LinkType.none: '',
  LinkType.product: 'product',
  LinkType.url: 'inputurl',
  LinkType.category: 'selcategory',
  LinkType.categoryView: 'selcategoryview',
  LinkType.neweventview: 'neweventview',
  LinkType.cart: 'cart',
  LinkType.order: 'orderlist',
  LinkType.favorite: 'favorite',
};

Sidebar _$SidebarFromJson(Map<String, dynamic> json) => Sidebar(
      json['brand_id'] as int,
      json['template_id'] as int,
      json['main_id'] as int,
      json['module_type'] as String,
      json['layout_id'] as int,
      JsonValueConverter.fromHex(json['logo_menu_back_color'] as String),
      JsonValueConverter.fromHex(json['logo_menu_img_color'] as String),
      JsonValueConverter.fromHex(json['end_menu_back_color'] as String),
      JsonValueConverter.fromHex(json['end_menu_img_color'] as String),
      $enumDecode(_$SidebarDirectionEnumMap, json['navigate_style']),
      (json['row'] as List<dynamic>)
          .map((e) => SidebarItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SidebarToJson(Sidebar instance) => <String, dynamic>{
      'brand_id': instance.brandId,
      'template_id': instance.templateId,
      'main_id': instance.mainId,
      'module_type': instance.moduleType,
      'layout_id': instance.id,
      'logo_menu_back_color': JsonValueConverter.toHex(instance.logoBackground),
      'logo_menu_img_color': JsonValueConverter.toHex(instance.logoTint),
      'end_menu_back_color':
          JsonValueConverter.toHex(instance.footerBackground),
      'end_menu_img_color': JsonValueConverter.toHex(instance.footerTint),
      'navigate_style': _$SidebarDirectionEnumMap[instance.direction],
      'row': instance.items,
    };

const _$SidebarDirectionEnumMap = {
  SidebarDirection.left: 'LEFT',
  SidebarDirection.right: 'RIGHT',
};

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
