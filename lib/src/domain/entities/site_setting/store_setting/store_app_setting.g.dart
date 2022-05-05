// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_app_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreAppSettingRemindItem _$StoreAppSettingRemindItemFromJson(
        Map<String, dynamic> json) =>
    StoreAppSettingRemindItem(
      json['is_enable'] as bool,
      json['message'] as String,
    );

Map<String, dynamic> _$StoreAppSettingRemindItemToJson(
        StoreAppSettingRemindItem instance) =>
    <String, dynamic>{
      'is_enable': instance.enabled,
      'message': instance.message,
    };

StoreAppSettingRemind _$StoreAppSettingRemindFromJson(
        Map<String, dynamic> json) =>
    StoreAppSettingRemind(
      StoreAppSettingRemindItem.fromJson(
          json['first_login'] as Map<String, dynamic>),
      StoreAppSettingRemindItem.fromJson(
          json['register'] as Map<String, dynamic>),
      StoreAppSettingRemindItem.fromJson(
          json['birthday'] as Map<String, dynamic>),
      StoreAppSettingRemindItem.fromJson(json['order'] as Map<String, dynamic>),
      StoreAppSettingRemindItem.fromJson(
          json['personal_offer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoreAppSettingRemindToJson(
        StoreAppSettingRemind instance) =>
    <String, dynamic>{
      'first_login': instance.firstLogin,
      'register': instance.register,
      'birthday': instance.birthday,
      'order': instance.order,
      'personal_offer': instance.personalOffer,
    };

StoreAppSettingDownload _$StoreAppSettingDownloadFromJson(
        Map<String, dynamic> json) =>
    StoreAppSettingDownload(
      json['is_ios'] as bool,
      json['ios_url'] as String,
      json['is_android'] as bool,
      json['android_url'] as String,
    );

Map<String, dynamic> _$StoreAppSettingDownloadToJson(
        StoreAppSettingDownload instance) =>
    <String, dynamic>{
      'is_ios': instance.iosEnabled,
      'ios_url': instance.iosUri,
      'is_android': instance.androidEnabled,
      'android_url': instance.androidUri,
    };

StoreAppSettingPush _$StoreAppSettingPushFromJson(Map<String, dynamic> json) =>
    StoreAppSettingPush(
      JsonValueConverter.intFromString(json['day_amount'] as String?),
    );

Map<String, dynamic> _$StoreAppSettingPushToJson(
        StoreAppSettingPush instance) =>
    <String, dynamic>{
      'day_amount': JsonValueConverter.intToString(instance.amount),
    };

StoreAppSetting _$StoreAppSettingFromJson(Map<String, dynamic> json) =>
    StoreAppSetting(
      StoreAppSettingRemind.fromJson(
          json['app_remind'] as Map<String, dynamic>),
      StoreAppSettingDownload.fromJson(
          json['app_download'] as Map<String, dynamic>),
      StoreAppSettingPush.fromJson(json['app_push'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoreAppSettingToJson(StoreAppSetting instance) =>
    <String, dynamic>{
      'app_remind': instance.remind,
      'app_download': instance.download,
      'app_push': instance.push,
    };
