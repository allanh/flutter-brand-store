// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreSetting _$StoreSettingFromJson(Map<String, dynamic> json) => StoreSetting(
      json['domain'] as String,
      Partner.fromJson(json['partner'] as Map<String, dynamic>),
      Basic.fromJson(json['basic'] as Map<String, dynamic>),
      FrontPage.fromJson(json['front_page'] as Map<String, dynamic>),
      ThirdParty.fromJson(json['third_party'] as Map<String, dynamic>),
      Login.fromJson(json['login'] as Map<String, dynamic>),
      Customer.fromJson(json['customer'] as Map<String, dynamic>),
      Payment.fromJson(json['payment'] as Map<String, dynamic>),
      Invoice.fromJson(json['invoice'] as Map<String, dynamic>),
      StoreAppSetting.fromJson(json['app'] as Map<String, dynamic>),
      StoreOrderSetting.fromJson(json['order'] as Map<String, dynamic>),
      Trace.fromJson(json['tracing_code'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoreSettingToJson(StoreSetting instance) =>
    <String, dynamic>{
      'domain': instance.domain,
      'partner': instance.partner,
      'basic': instance.basic,
      'front_page': instance.frontPage,
      'third_party': instance.thirdParty,
      'login': instance.login,
      'customer': instance.customer,
      'payment': instance.payment,
      'invoice': instance.invoice,
      'app': instance.appSetting,
      'order': instance.order,
      'tracing_code': instance.trace,
    };
