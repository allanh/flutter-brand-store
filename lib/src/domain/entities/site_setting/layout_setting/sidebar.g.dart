// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidebar.dart';

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
