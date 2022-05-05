// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreInfo _$StoreInfoFromJson(Map<String, dynamic> json) => StoreInfo(
      json['name'] as String,
      json['business_hour'] as String,
      json['tel'] as String,
      json['remark'] as String,
      Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoreInfoToJson(StoreInfo instance) => <String, dynamic>{
      'name': instance.name,
      'business_hour': instance.businessHour,
      'tel': instance.phone,
      'remark': instance.remark,
      'address': instance.address,
    };

Basic _$BasicFromJson(Map<String, dynamic> json) => Basic(
      json['name'] as String,
      json['company_name'] as String,
      json['unified_business_no'] as String,
      StoreInfo.fromJson(json['store_info'] as Map<String, dynamic>),
      json['introduction'] as String,
      json['cs_email'] as String,
      json['title'] as String,
      json['keywords'] as String,
      json['logo_image_id'] as int,
      json['logo_image'] as String,
      JsonValueConverter.sortOptionsFromString(json['category_sort'] as String),
    );

Map<String, dynamic> _$BasicToJson(Basic instance) => <String, dynamic>{
      'name': instance.name,
      'company_name': instance.company,
      'unified_business_no': instance.businessNo,
      'store_info': instance.store,
      'introduction': instance.introduction,
      'cs_email': instance.email,
      'title': instance.title,
      'keywords': instance.keywords,
      'logo_image_id': instance.logoID,
      'logo_image': instance.logoUrl,
      'category_sort': JsonValueConverter.sortOptionToString(instance.sort),
    };
