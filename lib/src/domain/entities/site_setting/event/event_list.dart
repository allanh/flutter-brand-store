import 'package:json_annotation/json_annotation.dart';

import '../../link.dart';

part 'event_list.g.dart';

@JsonSerializable()
class EventListItem {
  EventListItem(this.title, this.type, this.value);
  static EventListItem get empty {
    return EventListItem('', LinkType.none, '');
  }

  final String title;
  @JsonKey(name: 'link')
  final LinkType type;
  @JsonKey(name: 'link_data')
  final dynamic value;

  factory EventListItem.fromJson(Map<String, dynamic> json) => _$EventListItemFromJson(json);
  Map<String, dynamic> toJson() => _$EventListItemToJson(this);
}
class EventList {
  EventList(this.listTitle, this.items);

  final EventListItem? listTitle;
  final List<EventListItem> items;
}
