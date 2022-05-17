import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

import '../../../../data/helper/json_value_converter.dart';
import '../../link.dart';

part 'sidebar.g.dart';

enum SidebarDirection {
  @JsonValue('LEFT') left,
  @JsonValue('RIGHT') right
}
@JsonSerializable()
class SidebarItem {
  SidebarItem(this.title, this.linkType, this.linkValue, this.children);

  final String title;
  @JsonKey(name: 'link')
  final LinkType linkType;
  @JsonKey(name:'link_data')
  final String linkValue;
  Link get link {
    return Link(linkType, linkValue);
  }
  final List<SidebarItem> children;

  factory SidebarItem.fromJson(Map<String, dynamic> json) => _$SidebarItemFromJson(json);
  Map<String, dynamic> toJson() => _$SidebarItemToJson(this);
}
@JsonSerializable()
class Sidebar {
  Sidebar(this.brandId, this.templateId, this.mainId, this.moduleType, this.id, this.logoBackground, this.logoTint, this.footerBackground, this.footerTint, this.direction, this.items);

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
  @JsonKey(name: 'logo_menu_back_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  final Color logoBackground;
  @JsonKey(name: 'logo_menu_img_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  final Color logoTint;
  @JsonKey(name: 'end_menu_back_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  final Color footerBackground;
  @JsonKey(name: 'end_menu_img_color', fromJson: JsonValueConverter.fromHex, toJson: JsonValueConverter.toHex)
  final Color footerTint;
  @JsonKey(name: 'navigate_style')
  final SidebarDirection direction;
  @JsonKey(name: 'row')
  final List<SidebarItem> items;

  static Sidebar get empty {
    return Sidebar(0, 0, 0, '', 0, Colors.black, Colors.white, Colors.black, Colors.white, SidebarDirection.left, []);
  }
  factory Sidebar.fromJson(Map<String, dynamic> json) => _$SidebarFromJson(json);
  Map<String, dynamic> toJson() => _$SidebarToJson(this);
}
