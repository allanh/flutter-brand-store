// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trace _$TraceFromJson(Map<String, dynamic> json) => Trace(
      json['is_enabled'] as bool,
      json['is_gtm'] as bool,
      json['google_gtm_no'] as String?,
      json['google_ga_no'] as String?,
      json['google_gads_no'] as String?,
      json['google_gads_tag'] as String?,
      json['facebook_pixel_no'] as String?,
      json['yahoo_project_id'] as String?,
      json['yahoo_pixel_id'] as String?,
    );

Map<String, dynamic> _$TraceToJson(Trace instance) => <String, dynamic>{
      'is_enabled': instance.enabled,
      'is_gtm': instance.gtm,
      'google_gtm_no': instance.googleGtmNo,
      'google_ga_no': instance.googleGaNo,
      'google_gads_no': instance.googleGadsNo,
      'google_gads_tag': instance.googleGadsTag,
      'facebook_pixel_no': instance.facebookPixelNo,
      'yahoo_project_id': instance.yahooProjectId,
      'yahoo_pixel_id': instance.yahooPixelId,
    };
