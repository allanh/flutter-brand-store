
import 'package:json_annotation/json_annotation.dart';

import 'independent_setting.dart';
import 'sidebar.dart';

part 'layout_setting.g.dart';


@JsonSerializable()
class LayoutSetting {
  LayoutSetting(this.setting, this.sidebar);
  static LayoutSetting get empty {
    return LayoutSetting(IndependentSetting.empty, Sidebar.empty);
  }

  @JsonKey(name: 'setting')
  final IndependentSetting setting;
  @JsonKey(name: 'sidebar_mobile')
  final Sidebar sidebar;

  factory LayoutSetting.fromJson(Map<String, dynamic> json) => _$LayoutSettingFromJson(json);
  Map<String, dynamic> toJson() => _$LayoutSettingToJson(this);
}
