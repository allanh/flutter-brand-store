// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventListItem _$EventListItemFromJson(Map<String, dynamic> json) =>
    EventListItem(
      json['title'] as String,
      $enumDecode(_$LinkTypeEnumMap, json['link']),
      json['link_data'],
    );

Map<String, dynamic> _$EventListItemToJson(EventListItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': _$LinkTypeEnumMap[instance.type],
      'link_data': instance.value,
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
