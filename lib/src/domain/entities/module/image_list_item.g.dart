// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageListItem _$ImageListItemFromJson(Map<String, dynamic> json) =>
    ImageListItem(
      json['img'] as String,
      $enumDecode(_$LinkTypeEnumMap, json['sub_link']),
      json['sub_link_data'] as String,
      JsonValueConverter.boolFromInt(json['sub_enable'] as int),
    )
      ..title = json['title'] as String?
      ..content = json['content'] as String?
      ..start = json['sub_sdate'] == null
          ? null
          : DateTime.parse(json['sub_sdate'] as String)
      ..end = json['sub_edate'] == null
          ? null
          : DateTime.parse(json['sub_edate'] as String);

Map<String, dynamic> _$ImageListItemToJson(ImageListItem instance) =>
    <String, dynamic>{
      'img': instance.image,
      'title': instance.title,
      'content': instance.content,
      'sub_sdate': instance.start?.toIso8601String(),
      'sub_edate': instance.end?.toIso8601String(),
      'sub_link': _$LinkTypeEnumMap[instance.linkType],
      'sub_link_data': instance.linkValue,
      'sub_enable': JsonValueConverter.boolToInt(instance.enabled),
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
  LinkType.allEvent: 'newevent',
  LinkType.event: 'neweventview',
};
