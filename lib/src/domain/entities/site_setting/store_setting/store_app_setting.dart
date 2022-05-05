
import 'package:json_annotation/json_annotation.dart';

import '../../../../data/helper/json_value_converter.dart';

part 'store_app_setting.g.dart';

// App
@JsonSerializable()
class StoreAppSettingRemindItem {
  StoreAppSettingRemindItem(this.enabled, this.message);
  static StoreAppSettingRemindItem get empty {
    return StoreAppSettingRemindItem(false, '');
  }

  @JsonKey(name: 'is_enable')
  final bool enabled;
  final String message;

  factory StoreAppSettingRemindItem.fromJson(Map<String, dynamic> json) => _$StoreAppSettingRemindItemFromJson(json);
  Map<String, dynamic> toJson() => _$StoreAppSettingRemindItemToJson(this);
}
@JsonSerializable()
class StoreAppSettingRemind {
  StoreAppSettingRemind(this.firstLogin, this.register, this.birthday, this.order, this.personalOffer);
  static StoreAppSettingRemind get empty {
    return StoreAppSettingRemind(StoreAppSettingRemindItem.empty, StoreAppSettingRemindItem.empty, StoreAppSettingRemindItem.empty, StoreAppSettingRemindItem.empty, StoreAppSettingRemindItem.empty);
  }

  @JsonKey(name: 'first_login')
  StoreAppSettingRemindItem firstLogin;
  StoreAppSettingRemindItem register;
  StoreAppSettingRemindItem birthday;
  StoreAppSettingRemindItem order;
  @JsonKey(name: 'personal_offer')
  StoreAppSettingRemindItem personalOffer;
  
  factory StoreAppSettingRemind.fromJson(Map<String, dynamic> json) => _$StoreAppSettingRemindFromJson(json);
  Map<String, dynamic> toJson() => _$StoreAppSettingRemindToJson(this);
}
@JsonSerializable()
class StoreAppSettingDownload {
  StoreAppSettingDownload(this.iosEnabled, this.iosUri, this.androidEnabled, this.androidUri);
  static StoreAppSettingDownload get empty {
    return StoreAppSettingDownload(false, '', false, '');
  }

  @JsonKey(name: 'is_ios')
  final bool iosEnabled;
  @JsonKey(name: 'ios_url')
  final String iosUri;
  @JsonKey(name: 'is_android')
  final bool androidEnabled;
  @JsonKey(name: 'android_url')
  final String androidUri;
  
  factory StoreAppSettingDownload.fromJson(Map<String, dynamic> json) => _$StoreAppSettingDownloadFromJson(json);
  Map<String, dynamic> toJson() => _$StoreAppSettingDownloadToJson(this);
}
@JsonSerializable()
class StoreAppSettingPush {
  StoreAppSettingPush(this.amount);
  static StoreAppSettingPush get empty {
    return StoreAppSettingPush(0);
  }

  @JsonKey(name: 'day_amount', fromJson: JsonValueConverter.intFromString, toJson: JsonValueConverter.intToString)
  final int amount;
  
  factory StoreAppSettingPush.fromJson(Map<String, dynamic> json) => _$StoreAppSettingPushFromJson(json);
  Map<String, dynamic> toJson() => _$StoreAppSettingPushToJson(this);
}
@JsonSerializable()
class StoreAppSetting {
  StoreAppSetting(this.remind, this.download, this.push);
  static StoreAppSetting get empty {
    return StoreAppSetting(StoreAppSettingRemind.empty, StoreAppSettingDownload.empty, StoreAppSettingPush.empty);
  }

  @JsonKey(name: 'app_remind')
  StoreAppSettingRemind remind;
  @JsonKey(name: 'app_download')
  StoreAppSettingDownload download;
  @JsonKey(name: 'app_push')
  StoreAppSettingPush push;

  factory StoreAppSetting.fromJson(Map<String, dynamic> json) => _$StoreAppSettingFromJson(json);
  Map<String, dynamic> toJson() => _$StoreAppSettingToJson(this);
}
