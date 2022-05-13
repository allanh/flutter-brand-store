// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      $enumDecode(_$LinkTypeEnumMap, json['type']),
      json['value'] as String,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'type': _$LinkTypeEnumMap[instance.type],
      'value': instance.value,
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
