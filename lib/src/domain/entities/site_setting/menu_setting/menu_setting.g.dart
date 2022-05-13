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
      (json['children'] as List<dynamic>?)
              ?.map((e) => MenuSettingItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
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
      'children': instance.children,
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
  LinkType.bought: 'bought',
  LinkType.cookie: 'cookie',
  LinkType.updatemember: 'updatemember',
  LinkType.fastcheckout: 'fastcheckout',
  LinkType.orderqa: 'orderqa',
  LinkType.service: 'service',
  LinkType.membersetting: 'membersetting',
  LinkType.orderdetail: 'orderdetail',
  LinkType.allEvent: 'newevent',
  LinkType.event: 'neweventview',
};

MenuSettingSwitchItem _$MenuSettingSwitchItemFromJson(
        Map<String, dynamic> json) =>
    MenuSettingSwitchItem(
      $enumDecode(_$MenuSettingSwitchTypeEnumMap, json['name']),
      JsonValueConverter.boolFromString(json['status'] as String?),
    );

Map<String, dynamic> _$MenuSettingSwitchItemToJson(
        MenuSettingSwitchItem instance) =>
    <String, dynamic>{
      'name': _$MenuSettingSwitchTypeEnumMap[instance.type],
      'status': JsonValueConverter.boolToString(instance.enabled),
    };

const _$MenuSettingSwitchTypeEnumMap = {
  MenuSettingSwitchType.footer: 'menu_footer',
  MenuSettingSwitchType.news: 'news',
  MenuSettingSwitchType.category: 'prod_cat',
  MenuSettingSwitchType.menu: 'menu',
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
      (json['switch_mobile'] as List<dynamic>)
          .map((e) => MenuSettingSwitchItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuSettingToJson(MenuSetting instance) =>
    <String, dynamic>{
      'header': instance.headers,
      'footer': instance.footers,
      'hotkey_mobile': instance.hotKeys,
      'switch_mobile': instance.switchs,
    };
