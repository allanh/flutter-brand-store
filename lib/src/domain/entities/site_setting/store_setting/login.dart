
import 'dart:io';
import 'package:json_annotation/json_annotation.dart';

import '../../../../data/helper/json_value_converter.dart';

part 'login.g.dart';

// Login
enum RegisterMethod {
  @JsonValue(1) either,
  @JsonValue(2) email,
  @JsonValue(3) mobile,
}
class LoginItem {
  LoginItem(this.id, this.secret, this.enabled);

  final String? id;
  final String? secret;
  final bool enabled;
}
@JsonSerializable()
class Login {
  Login(this.method, this.appleId, this.appleSecret, this.googleEnabled, this.googleId, this.googleSecret, this.facebookEnabled, this.facebookId, this.facebookSecret, this.lineEnabled, this.lineId, this.lineSecret);
  static Login get empty {
    return Login(RegisterMethod.either, null, null, false, null, null, false, null, null, false, null, null,);
  }

  @JsonKey(name: 'register_method')
  final RegisterMethod method;
  @JsonKey(name: 'apple_bundle_id')
  final String? appleId;
  @JsonKey(name: 'apple_client_secret')
  final String? appleSecret;
  LoginItem get apple {
    return LoginItem(appleId, appleSecret, Platform.isIOS ? true : false);
  }
  @JsonKey(name: 'google_client_enabled', fromJson: JsonValueConverter.boolFromInt, toJson: JsonValueConverter.boolToInt)
  final bool googleEnabled;
  @JsonKey(name: 'google_client_id')
  final String? googleId;
  @JsonKey(name: 'google_client_secret')
  final String? googleSecret;
  LoginItem get google {
    return LoginItem(googleId, googleSecret, googleEnabled);
  }
  @JsonKey(name: 'facebook_client_enabled', fromJson: JsonValueConverter.boolFromInt, toJson: JsonValueConverter.boolToInt)
  final bool facebookEnabled;
  @JsonKey(name: 'facebook_client_id')
  final String? facebookId;
  @JsonKey(name: 'facebook_client_secret')
  final String? facebookSecret;
  LoginItem get facebook {
    return LoginItem(facebookId, facebookSecret, facebookEnabled);
  }
  @JsonKey(name: 'line_channel_enabled', fromJson: JsonValueConverter.boolFromInt, toJson: JsonValueConverter.boolToInt)
  final bool lineEnabled;
  @JsonKey(name: 'line_channel_id')
  final String? lineId;
  @JsonKey(name: 'line_channel_secret')
  final String? lineSecret;
  
  LoginItem get line {
    return LoginItem(lineId, lineSecret, lineEnabled);
  }

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
