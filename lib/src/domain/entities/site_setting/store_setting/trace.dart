import 'package:json_annotation/json_annotation.dart';

part 'trace.g.dart';

// Trace
@JsonSerializable()
class Trace {
  Trace(this.enabled, this.gtm, this.googleGtmNo, this.googleGaNo, this.googleGadsNo, this.googleGadsTag, this.facebookPixelNo, this.yahooProjectId, this.yahooPixelId);
  static Trace get empty {
    return Trace(false, false, null, null, null, null, null, null, null);
  }

  @JsonKey(name: 'is_enabled')
  final bool enabled;
  @JsonKey(name: 'is_gtm')
  final bool gtm;
  @JsonKey(name: 'google_gtm_no')
  final String? googleGtmNo;
  @JsonKey(name: 'google_ga_no')
  final String? googleGaNo;
  @JsonKey(name: 'google_gads_no')
  final String? googleGadsNo;
  @JsonKey(name: 'google_gads_tag')
  final String? googleGadsTag;
  @JsonKey(name: 'facebook_pixel_no')
  final String? facebookPixelNo;
  @JsonKey(name: 'yahoo_project_id')
  final String? yahooProjectId;
  @JsonKey(name: 'yahoo_pixel_id')
  final String? yahooPixelId;

  factory Trace.fromJson(Map<String, dynamic> json) => _$TraceFromJson(json);
  Map<String, dynamic> toJson() => _$TraceToJson(this);
}
