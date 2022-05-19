import 'package:json_annotation/json_annotation.dart';

import 'link.dart';

part 'drawer_list_item.g.dart';

@JsonSerializable()
class DrawerListItem {
  DrawerListItem(this.title, this.linkType, this.value, this.children);
  // @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'link')
  final LinkType linkType;
  @JsonKey(name: 'link_data')
  final dynamic value;
  get link => Link(linkType, value);
  @JsonKey(defaultValue: [])
  final List<DrawerListItem> children;

  factory DrawerListItem.fromJson(Map<String, dynamic> json) => _$DrawerListItemFromJson(json);
  Map<String, dynamic> toJson() => _$DrawerListItemToJson(this);

}
