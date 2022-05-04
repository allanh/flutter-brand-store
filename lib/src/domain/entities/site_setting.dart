import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import './response.dart';
import './layout_setting.dart';

export './layout_setting.dart';

part 'site_setting.g.dart';


@JsonSerializable()
class SiteStatus {
  SiteStatus(this.commingSoon, this.name, this.host, this.captchaKey);
  @JsonKey(name: 'coming_soon')
  bool commingSoon;
  String name;
  String host;
  @JsonKey(name: 're_captcha_site_key')
  String captchaKey;
  factory SiteStatus.fromJson(Map<String, dynamic> json) => _$SiteStatusFromJson(json);
  Map<String, dynamic> toJson() => _$SiteStatusToJson(this);
}

@JsonSerializable()
class SiteSetting {
  SiteSetting(this.date, this.annonmousKey, this.status, this.layout);
  static late SiteSetting current;
  DateTime date;
  @JsonKey(name: 'anonkey')
  String annonmousKey;
  @JsonKey(name: 'site')
  SiteStatus status;
  // @JsonKey(name: 'store_setting')
  // StoreSetting store;
  @JsonKey(name: 'layout_setting')
  LayoutSetting layout;
  // @JsonKey(name: 'menu_setting')
  // MenuSetting menu;
  factory SiteSetting.fromJson(Map<String, dynamic> json) => _$SiteSettingFromJson(json);
  Map<String, dynamic> toJson() => _$SiteSettingToJson(this);
}
@JsonSerializable()
class SiteSettingResponse extends Response {
  SiteSettingResponse(this.setting) : super('', null, ResponseStatus.failure);
  @JsonKey(name: 'data')
  SiteSetting setting;
  factory SiteSettingResponse.fromJson(Map<String, dynamic> json) => _$SiteSettingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SiteSettingResponseToJson(this);
}
extension ThemeColor on Colors {
  static Color get theme {
    return SiteSetting.current.layout.setting.theme;
  }
  static Color get text {
    return SiteSetting.current.layout.setting.title;
  }
  static Color get memberCenter {
    return SiteSetting.current.layout.setting.memberBackground;
  }
  static Color get navagationBackground {
    return SiteSetting.current.layout.sidebar.logoBackground;
  }
  static Color get navigationTint {
    return SiteSetting.current.layout.sidebar.logoTint;
  }
  static Color get bottomBarBackground {
    return SiteSetting.current.layout.sidebar.footerBackground;
  }
  static Color get bottomBarTint {
    return SiteSetting.current.layout.sidebar.footerTint;
  }
  static Color get themeSecondary {
    return SiteSetting.current.layout.setting.focus;
  }
  
}
