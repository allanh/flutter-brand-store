import 'package:json_annotation/json_annotation.dart';

import '../../drawer_list_item.dart';
import '../../link.dart';

part 'event_list.g.dart';


@JsonSerializable()
class EventListItem extends DrawerListItem {
  EventListItem({required String title, required LinkType linkType, dynamic value, required List<DrawerListItem> children}) : super(title, linkType, value, children);
  static EventListItem get empty {
    return EventListItem(title: '', linkType: LinkType.none, value: '', children: []);
  }

  factory EventListItem.fromJson(Map<String, dynamic> json) => _$EventListItemFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$EventListItemToJson(this);
}
class EventList {
  EventList(this.listTitle, this.items);

  final EventListItem? listTitle;
  final List<EventListItem> items;
}
