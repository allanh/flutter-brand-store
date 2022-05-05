// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      json['zipcode'] as String,
      json['county'] as String,
      json['district'] as String,
      json['address'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'zipcode': instance.zip,
      'county': instance.county,
      'district': instance.district,
      'address': instance.address,
    };
