import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../data/helper/json_value_converter.dart';

part 'independent_setting.g.dart';

@JsonSerializable()
class LogoItem {
  LogoItem(this.uri);
  static LogoItem get empty {
    return LogoItem('');
  }

  @JsonKey(name: 'url')
  final String uri;

  factory LogoItem.fromJson(Map<String, dynamic> json) => _$LogoItemFromJson(json);
  Map<String, dynamic> toJson() => _$LogoItemToJson(this);
}
@JsonSerializable()
class Logo {
  Logo(this.pc, this.mobile1, this.mobile2);
  static Logo get empty {
    return Logo(LogoItem.empty, LogoItem.empty, LogoItem.empty);
  }

  final LogoItem pc;
  @JsonKey(name: 'mobile_1')
  final LogoItem mobile1;
  @JsonKey(name: 'mobile_2')
  final LogoItem mobile2;

  factory Logo.fromJson(Map<String, dynamic> json) => _$LogoFromJson(json);
  Map<String, dynamic> toJson() => _$LogoToJson(this);
}

@JsonSerializable()
class IndependentSetting {
  IndependentSetting(this.brandId, this.templateId, this.mainId, this.moduleType, this.id, this.maxWidth, this.theme, this.memberBackground, this.focus, this.borderTitleBackground, this.title, this.productImageBorder, this.productImageBorderRadius, this.productImageBorderShadow, this.logo);
  static IndependentSetting get empty {
    return IndependentSetting(0, 0, 0, '', 0, 0, Colors.black, Colors.black, Colors.black, Colors.black, Colors.white, false, false, false, Logo.empty);
  }

  @JsonKey(name: 'brand_id')
  final int brandId;
  @JsonKey(name: 'template_id')
  final int templateId;
  @JsonKey(name: 'main_id')
  final int mainId;
  @JsonKey(name: 'module_type')
  final String moduleType;
  @JsonKey(name: 'layout_id')
  final int id;
  @JsonKey(name: 'max_width')
  final int maxWidth;
  @JsonKey(name: 'theme_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  final Color theme;
  @JsonKey(name: 'mem_back_color_value', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  final Color memberBackground;
  // mem_back_color
  @JsonKey(name: 'focus_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  final Color focus;
  // icon
  @JsonKey(name: 'border_title_back_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  final Color borderTitleBackground;
  @JsonKey(name: 'title_text_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  final Color title;
  // title_style
  @JsonKey(name: 'prod_img_border', fromJson: JsonValueConverter.boolFromString, toJson: JsonValueConverter.boolToString)
  final bool productImageBorder;
  @JsonKey(name: 'prod_img_border_radius', fromJson: JsonValueConverter.boolFromString, toJson: JsonValueConverter.boolToString)
  final bool productImageBorderRadius;
  @JsonKey(name: 'prod_img_border_shadow', fromJson: JsonValueConverter.boolFromString, toJson: JsonValueConverter.boolToString)
  final bool productImageBorderShadow;
  // prod_img_transform
  // ranking_tag
  @JsonKey(name: 'img')
  final Logo logo;

  factory IndependentSetting.fromJson(Map<String, dynamic> json) => _$IndependentSettingFromJson(json);
  Map<String, dynamic> toJson() => _$IndependentSettingToJson(this);

}
