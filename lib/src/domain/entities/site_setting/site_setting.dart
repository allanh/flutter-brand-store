import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'layout_setting/layout_setting.dart';
import 'store_setting/store_setting.dart';
import 'menu_setting/menu_setting.dart';
import 'event/event_list.dart';

part 'site_setting.g.dart';


@JsonSerializable()
class SiteStatus {
  SiteStatus(this.commingSoon, this.name, this.host, this.captchaKey);
  static SiteStatus get empty {
    return SiteStatus(false, '', '', '');
  }

  @JsonKey(name: 'coming_soon')
  final bool commingSoon;
  final String name;
  final String host;
  @JsonKey(name: 're_captcha_site_key')
  final String captchaKey;

  factory SiteStatus.fromJson(Map<String, dynamic> json) => _$SiteStatusFromJson(json);
  Map<String, dynamic> toJson() => _$SiteStatusToJson(this);
}

@JsonSerializable()
class SiteSetting {
  SiteSetting(this.date, this.annonmousKey, this.status, this.store, this.layout, this.menu, this.listTitle, this.listItems);
  static late SiteSetting current = SiteSetting(DateTime.now(), '', SiteStatus.empty, StoreSetting.empty, LayoutSetting.empty, MenuSetting.empty, EventListItem.empty, []);
  // static SiteSetting get current =>  _current;
  static late ValueNotifier<SiteSetting> notifier = ValueNotifier(SiteSetting.current);

  final DateTime date;
  @JsonKey(name: 'anonkey')
  final String annonmousKey;
  @JsonKey(name: 'site')
  final SiteStatus status;
  @JsonKey(name: 'store_setting')
  final StoreSetting store;// current
  @JsonKey(name: 'layout_setting')
  final LayoutSetting layout;
  @JsonKey(name: 'menu_setting')
  final MenuSetting menu;
  @JsonKey(name: 'new_event_title')
  final EventListItem? listTitle;
  @JsonKey(name: 'new_event_list', defaultValue: [])
  final List<EventListItem> listItems;
  EventList get eventList {
    return EventList(listTitle, listItems);
  }
  
  factory SiteSetting.fromJson(Map<String, dynamic> json) {
    current = _$SiteSettingFromJson(json);
    notifier.value = current;
    return SiteSetting.current;
  }
  Map<String, dynamic> toJson() => _$SiteSettingToJson(this);
}
