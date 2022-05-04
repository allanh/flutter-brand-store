import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

import './link.dart';
import '../../data/helper/json_value_converter.dart';

part 'layout_setting.g.dart';

enum SidebarDirection {
  @JsonValue('LEFT') left,
  @JsonValue('RIGHT') right
}
@JsonSerializable()
class SidebarItem {
  SidebarItem(this.title, this.linkType, this.linkValue, this.children);
  String title;
  @JsonKey(name: 'link')
  LinkType linkType;
  @JsonKey(name:'link_data')
  String linkValue;
  Link get link {
    return Link(linkType, linkValue);
  }
  List<SidebarItem> children;

  factory SidebarItem.fromJson(Map<String, dynamic> json) => _$SidebarItemFromJson(json);

  String get expandedValue => title;
  String get headerValue => title;
  Map<String, dynamic> toJson() => _$SidebarItemToJson(this);
}
@JsonSerializable()
class Sidebar {
  Sidebar(this.brandId, this.templateId, this.mainId, this.moduleType, this.id, this.logoBackground, this.logoTint, this.footerBackground, this.footerTint, this.direction, this.items);

  @JsonKey(name: 'brand_id')
  int brandId;
  @JsonKey(name: 'template_id')
  int templateId;
  @JsonKey(name: 'main_id')
  int mainId;
  @JsonKey(name: 'module_type')
  String moduleType;
  @JsonKey(name: 'layout_id')
  int id;
  @JsonKey(name: 'logo_menu_back_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  Color logoBackground;
  @JsonKey(name: 'logo_menu_img_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  Color logoTint;
  @JsonKey(name: 'end_menu_back_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  Color footerBackground;
  @JsonKey(name: 'end_menu_img_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  Color footerTint;
  @JsonKey(name: 'navigate_style')
  SidebarDirection direction;
  @JsonKey(name: 'row')
  List<SidebarItem> items;

  factory Sidebar.fromJson(Map<String, dynamic> json) => _$SidebarFromJson(json);
  Map<String, dynamic> toJson() => _$SidebarToJson(this);
}
@JsonSerializable()
class LogoItem {
  LogoItem(this.uri);

  @JsonKey(name: 'url')
  String uri;

  factory LogoItem.fromJson(Map<String, dynamic> json) => _$LogoItemFromJson(json);
  Map<String, dynamic> toJson() => _$LogoItemToJson(this);
}
@JsonSerializable()
class Logo {
  Logo(this.pc, this.mobile1, this.mobile2);

  LogoItem pc;
  @JsonKey(name: 'mobile_1')
  LogoItem mobile1;
  @JsonKey(name: 'mobile_2')
  LogoItem mobile2;

  factory Logo.fromJson(Map<String, dynamic> json) => _$LogoFromJson(json);
  Map<String, dynamic> toJson() => _$LogoToJson(this);
}
@JsonSerializable()
class IndependentSetting {
  IndependentSetting(this.brandId, this.templateId, this.mainId, this.moduleType, this.id, this.maxWidth, this.theme, this.memberBackground, this.focus, this.borderTitleBackground, this.title, this.productImageBorder, this.productImageBorderRadius, this.productImageBorderShadow, this.logo);

  @JsonKey(name: 'brand_id')
  int brandId;
  @JsonKey(name: 'template_id')
  int templateId;
  @JsonKey(name: 'main_id')
  int mainId;
  @JsonKey(name: 'module_type')
  String moduleType;
  @JsonKey(name: 'layout_id')
  int id;
  @JsonKey(name: 'max_width')
  int maxWidth;
  @JsonKey(name: 'theme_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  Color theme;
  @JsonKey(name: 'mem_back_color_value', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  Color memberBackground;
  // mem_back_color
  @JsonKey(name: 'focus_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  Color focus;
  // icon
  @JsonKey(name: 'border_title_back_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  Color borderTitleBackground;
  @JsonKey(name: 'title_text_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  Color title;
  // title_style
  @JsonKey(name: 'prod_img_border', fromJson: JsonValueConverter.boolFromString, toJson: JsonValueConverter.boolToString)
  bool productImageBorder;
  @JsonKey(name: 'prod_img_border_radius', fromJson: JsonValueConverter.boolFromString, toJson: JsonValueConverter.boolToString)
  bool productImageBorderRadius;
  @JsonKey(name: 'prod_img_border_shadow', fromJson: JsonValueConverter.boolFromString, toJson: JsonValueConverter.boolToString)
  bool productImageBorderShadow;
  // prod_img_transform
  // ranking_tag
  @JsonKey(name: 'img')
  Logo logo;
  

  factory IndependentSetting.fromJson(Map<String, dynamic> json) => _$IndependentSettingFromJson(json);
  Map<String, dynamic> toJson() => _$IndependentSettingToJson(this);

}

@JsonSerializable()
class LayoutSetting {
  LayoutSetting(this.setting, this.sidebar);
  
  @JsonKey(name: 'setting')
  IndependentSetting setting;
  @JsonKey(name: 'sidebar_mobile')
  Sidebar sidebar;
  factory LayoutSetting.fromJson(Map<String, dynamic> json) => _$LayoutSettingFromJson(json);
  Map<String, dynamic> toJson() => _$LayoutSettingToJson(this);
}
