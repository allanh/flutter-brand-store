// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      $enumDecode(_$RegisterMethodEnumMap, json['register_method']),
      json['apple_bundle_id'] as String?,
      json['apple_client_secret'] as String?,
      JsonValueConverter.boolFromInt(json['google_client_enabled'] as int),
      json['google_client_id'] as String?,
      json['google_client_secret'] as String?,
      JsonValueConverter.boolFromInt(json['facebook_client_enabled'] as int),
      json['facebook_client_id'] as String?,
      json['facebook_client_secret'] as String?,
      JsonValueConverter.boolFromInt(json['line_channel_enabled'] as int),
      json['line_channel_id'] as String?,
      json['line_channel_secret'] as String?,
    );

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'register_method': _$RegisterMethodEnumMap[instance.method],
      'apple_bundle_id': instance.appleId,
      'apple_client_secret': instance.appleSecret,
      'google_client_enabled':
          JsonValueConverter.boolToInt(instance.googleEnabled),
      'google_client_id': instance.googleId,
      'google_client_secret': instance.googleSecret,
      'facebook_client_enabled':
          JsonValueConverter.boolToInt(instance.facebookEnabled),
      'facebook_client_id': instance.facebookId,
      'facebook_client_secret': instance.facebookSecret,
      'line_channel_enabled':
          JsonValueConverter.boolToInt(instance.lineEnabled),
      'line_channel_id': instance.lineId,
      'line_channel_secret': instance.lineSecret,
    };

const _$RegisterMethodEnumMap = {
  RegisterMethod.either: 1,
  RegisterMethod.email: 2,
  RegisterMethod.mobile: 3,
};
