import 'package:json_annotation/json_annotation.dart';

import '../../../../data/helper/json_value_converter.dart';
import '../../link.dart';

part 'menu_setting.g.dart';

enum MenuCategory {
  @JsonValue('MAIN') main,
  @JsonValue('SUB') sub,
}
@JsonSerializable()
class MenuSettingItem {
  MenuSettingItem(this.mainID, this.patentID, this.category, this.isFolder, this.title, this.linkType, this.linkData, this.children);
  
  @JsonKey(name: 'main_id')
  final int mainID;
  @JsonKey(name: 'parent_id')
  final int? patentID;
  @JsonKey(name: 'menu_category')
  final MenuCategory? category;
  @JsonKey(name: 'folder_switch', fromJson: JsonValueConverter.boolFromString, toJson: JsonValueConverter.boolToString)
  final bool? isFolder;
  final String title;
  @JsonKey(name: 'link')
  final LinkType linkType;
  @JsonKey(name: 'link_data')
  final String linkData;
  Link get link {
    return Link(linkType, linkData);
  }
  @JsonKey(defaultValue: [])
  final List<MenuSettingItem> children;
  
  factory MenuSettingItem.fromJson(Map<String, dynamic> json) => _$MenuSettingItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuSettingItemToJson(this);
}
enum MenuSettingSwitchType {
  @JsonValue('menu_footer') footer,
  @JsonValue('news') news,
  @JsonValue('prod_cat') category,
  @JsonValue('menu') menu,
}
@JsonSerializable()
class MenuSettingSwitchItem {
  MenuSettingSwitchItem(this.type, this.enabled);

  @JsonKey(name: 'name')
  final MenuSettingSwitchType type;
  @JsonKey(name: 'status', fromJson: JsonValueConverter.boolFromString, toJson: JsonValueConverter.boolToString)
  final bool enabled;

  factory MenuSettingSwitchItem.fromJson(Map<String, dynamic> json) => _$MenuSettingSwitchItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuSettingSwitchItemToJson(this);
}
@JsonSerializable()
class MenuSetting {
  MenuSetting(this.headers, this.footers, this.hotKeys, this.switchs);
  static MenuSetting get empty {
    return MenuSetting([], [], [], []);
  }

  @JsonKey(name: 'header')
  final List<MenuSettingItem> headers;
  @JsonKey(name: 'footer')
  final List<MenuSettingItem> footers;
  @JsonKey(name: 'hotkey_mobile')
  final List<MenuSettingItem> hotKeys;
  @JsonKey(name: 'switch_mobile')
  final List<MenuSettingSwitchItem> switchs;

  factory MenuSetting.fromJson(Map<String, dynamic> json) => _$MenuSettingFromJson(json);
  Map<String, dynamic> toJson() => _$MenuSettingToJson(this);
}
