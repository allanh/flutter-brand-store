// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuSettingItem _$MenuSettingItemFromJson(Map<String, dynamic> json) =>
    MenuSettingItem(
      json['main_id'] as int,
      json['parent_id'] as int?,
      $enumDecodeNullable(_$MenuCategoryEnumMap, json['menu_category']),
      JsonValueConverter.boolFromString(json['folder_switch'] as String?),
      json['title'] as String,
      $enumDecode(_$LinkTypeEnumMap, json['link']),
      json['link_data'] as String,
    );

Map<String, dynamic> _$MenuSettingItemToJson(MenuSettingItem instance) =>
    <String, dynamic>{
      'main_id': instance.mainID,
      'parent_id': instance.patentID,
      'menu_category': _$MenuCategoryEnumMap[instance.category],
      'folder_switch': JsonValueConverter.boolToString(instance.isFolder),
      'title': instance.title,
      'link': _$LinkTypeEnumMap[instance.linkType],
      'link_data': instance.linkData,
    };

const _$MenuCategoryEnumMap = {
  MenuCategory.main: 'MAIN',
  MenuCategory.sub: 'SUB',
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

MenuSetting _$MenuSettingFromJson(Map<String, dynamic> json) => MenuSetting(
      (json['header'] as List<dynamic>)
          .map((e) => MenuSettingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['footer'] as List<dynamic>)
          .map((e) => MenuSettingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['hotkey_mobile'] as List<dynamic>)
          .map((e) => MenuSettingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuSettingToJson(MenuSetting instance) =>
    <String, dynamic>{
      'header': instance.headers,
      'footer': instance.footers,
      'hotkey_mobile': instance.hotKeys,
    };
