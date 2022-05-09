// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleItem _$ModuleItemFromJson(Map<String, dynamic> json) => ModuleItem(
      json['prod_image'] as String?,
      json['prod_name'] as String,
      json['prod_price'] as int,
      json['prod_recom'] as String?,
      Link.fromJson(json['link'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ModuleItemToJson(ModuleItem instance) =>
    <String, dynamic>{
      'prod_image': instance.image,
      'prod_name': instance.name,
      'prod_price': instance.price,
      'prod_recom': instance.recommend,
      'link': instance.link,
    };

Module _$ModuleFromJson(Map<String, dynamic> json) => Module(
      $enumDecode(_$ModuleTypeEnumMap, json['module_type']),
      json['layout_id'] as int,
      json['template_id'] as int,
      json['main_id'] as int,
      JsonValueConverter.boolFromString(json['show_module_title'] as String?),
      json['module_title'] as String,
    )
      ..limit = json['prod_limit'] as int?
      ..showProductName =
          JsonValueConverter.boolFromString(json['show_prodname'] as String?)
      ..showProductPrice =
          JsonValueConverter.boolFromString(json['show_prodprice'] as String?)
      ..products = (json['prod_list'] as List<dynamic>?)
          ?.map((e) => ModuleItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..referModulrID = json['ref_module_id'] as int?
      ..size = $enumDecodeNullable(_$ImageListItemSizeEnumMap, json['img_size'])
      ..images = (json['img_list'] as List<dynamic>?)
          ?.map((e) => ImageListItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'module_type': _$ModuleTypeEnumMap[instance.type],
      'layout_id': instance.layoutID,
      'template_id': instance.templateID,
      'main_id': instance.mainID,
      'show_module_title': JsonValueConverter.boolToString(instance.showTitle),
      'module_title': instance.title,
      'prod_limit': instance.limit,
      'show_prodname':
          JsonValueConverter.boolToString(instance.showProductName),
      'show_prodprice':
          JsonValueConverter.boolToString(instance.showProductPrice),
      'prod_list': instance.products,
      'ref_module_id': instance.referModulrID,
      'img_size': _$ImageListItemSizeEnumMap[instance.size],
      'img_list': instance.images,
    };

const _$ModuleTypeEnumMap = {
  ModuleType.product: 'prod',
  ModuleType.ad: 'ad',
};

const _$ImageListItemSizeEnumMap = {
  ImageListItemSize.small: 'S',
  ImageListItemSize.medium: 'M',
  ImageListItemSize.large: 'L',
};

ModuleList _$ModuleListFromJson(Map<String, dynamic> json) => ModuleList(
      json['layout_id'] as int,
      (json['result'] as List<dynamic>)
          .map((e) => Module.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModuleListToJson(ModuleList instance) =>
    <String, dynamic>{
      'layout_id': instance.layoutID,
      'result': instance.modules,
    };
