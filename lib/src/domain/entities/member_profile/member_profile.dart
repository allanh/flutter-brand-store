import 'package:json_annotation/json_annotation.dart';
import 'package:brandstores/src/data/helper/json_value_converter.dart';
import 'package:intl/intl.dart';

part 'member_profile.g.dart';

/// M=男/F=女/O=不公開，允许值: M, F, O
enum Gender {
  @JsonValue('M')
  male,
  @JsonValue('F')
  female,
  @JsonValue('O')
  other
}

@JsonSerializable()
class MemberProfileResponse {
  const MemberProfileResponse(this.id, this.status, this.message, this.profile);

  final String id;
  final String status;
  final String? message;

  /// 會員資料
  @JsonKey(name: 'data')
  final MemberProfile? profile;

  factory MemberProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MemberProfileResponseToJson(this);
}

@JsonSerializable()
class MemberProfile {
  const MemberProfile(
      this.name,
      this.countryCode,
      this.mobile,
      this.areaCode,
      this.phone,
      this.ext,
      this.email,
      this.gender,
      this.birthday,
      this.birthdayModifyCount,
      this.zipCode,
      this.city,
      this.area,
      this.address,
      this.isSettingPassword,
      this.isVerifyEmail,
      this.isVerifyMobile,
      this.bindingInfo);

  final String? name;

  /// 手機國碼
  @JsonKey(name: 'mobile_code')
  final String? countryCode;

  final String? mobile;

  String get sensitiveMobile {
    return '+$countryCode ${mobile?.replaceRange(2, 8, '******')}';
  }

  @JsonKey(name: 'area_code')
  final String? areaCode;

  @JsonKey(name: 'tel')
  final String? phone;

  ///分機號碼
  @JsonKey(name: 'tel_ext')
  final String? ext;

  final String? email;

  ///性別
  final Gender? gender;

  @JsonKey(name: 'birth')
  final String? birthday;

  /// 生日修改次數
  @JsonKey(name: 'birth_count')
  final int? birthdayModifyCount;

  @JsonKey(name: 'zip')
  final String? zipCode;

  @JsonKey(name: 'cityno')
  final String? city;

  @JsonKey(name: 'areano')
  final String? area;

  final String? address;

  /// 密碼(true=已設定密碼, false=無設定密碼)
  @JsonKey(name: 'pwd')
  final bool? isSettingPassword;

  /// 信箱是否已驗證
  @JsonKey(
      name: 'email_verify',
      fromJson: JsonValueConverter.boolFromString,
      toJson: JsonValueConverter.boolToString)
  final bool? isVerifyEmail;

  /// 手機是否已驗證
  @JsonKey(
      name: 'mobile_verify',
      fromJson: JsonValueConverter.boolFromString,
      toJson: JsonValueConverter.boolToString)
  final bool? isVerifyMobile;

  /// 第三方綁定資料
  @JsonKey(name: 'bundle_info')
  final BindingInfo? bindingInfo;

  factory MemberProfile.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileFromJson(json);
  Map<String, dynamic> toJson() => _$MemberProfileToJson(this);
}

@JsonSerializable()
class BindingInfo {
  const BindingInfo(this.facebookBinding, this.lineBinding, this.googleBinding,
      this.appleBinding);

  @JsonKey(name: 'FACEBOOK')
  final Binding? facebookBinding;
  String get facebookBindingImage {
    return 'assets/icon_circle_facebook.png';
  }

  @JsonKey(name: 'LINE')
  final Binding? lineBinding;
  String get lineBindingImage {
    return 'assets/icon_circle_line.png';
  }

  @JsonKey(name: 'GOOGLE')
  final Binding? googleBinding;
  String get googleBindingImage {
    return 'assets/icon_circle_google.png';
  }

  @JsonKey(name: 'APPLE')
  final Binding? appleBinding;
  String get appleBindingImage {
    return 'assets/icon_circle_apple.png';
  }

  factory BindingInfo.fromJson(Map<String, dynamic> json) =>
      _$BindingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BindingInfoToJson(this);
}

@JsonSerializable()
class Binding {
  const Binding(this.bindingId, this.openId);

  /// 會員與第三方的綁定 id
  @JsonKey(name: 'bundle_id')
  final int? bindingId;

  /// 第三方的 open id
  @JsonKey(name: 'openid')
  final String? openId;

  factory Binding.fromJson(Map<String, dynamic> json) =>
      _$BindingFromJson(json);
  Map<String, dynamic> toJson() => _$BindingToJson(this);
}
