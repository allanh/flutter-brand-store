import 'package:json_annotation/json_annotation.dart';

import '../../../data/helper/json_value_converter.dart';

part 'shipping_info.g.dart';

@JsonSerializable()
class ShippingInfoResponse {
  ShippingInfoResponse(
    // this.id,
    // this.status,
    // this.message,
    this.shippingInfos,
  );

  // final String id;
  // final String status;
  // final String? message;

  @JsonKey(name: 'detail')
  final List<ShippingInfo> shippingInfos;

  factory ShippingInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ShippingInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingInfoResponseToJson(this);
}

/// 收件人資訊
@JsonSerializable()
class ShippingInfo {
  ShippingInfo(
    this.id,
    this.infoName,
    this.name,
    this.countryCode,
    this.mobile,
    this.area,
    this.tel,
    this.ext,
    this.zipCode,
    this.county,
    this.district,
    this.address,
    this.isDefault,
  );

  /// 流水號
  @JsonKey(name: 'main_id')
  String? id;

  /// 地址名稱
  @JsonKey(name: 'post_custom_name')
  String? infoName;

  /// 收件人姓名
  @JsonKey(name: 'post_name')
  String? name;

  String get sensitiveName {
    return name?.length == 2

        /// 單名的時候隱碼最後一個字
        ? '${name?.replaceRange(1, 1, '*')}'
        : name?.length == 3

            /// 姓名三個字時，隱碼中間一個字
            ? '${name?.replaceRange(1, 2, '*')}'

            /// 姓名超過三個字的時候，隱碼兩個字
            : '${name?.replaceRange(1, 3, '*')}';
  }

  /// 國碼
  @JsonKey(name: 'post_country_code')
  String? countryCode;

  /// 收件人手機
  @JsonKey(name: 'post_mobile')
  String? mobile;

  String get sensitiveMobile {
    return '+$countryCode ${mobile?.replaceRange(2, 7, '** *** ')}';
  }

  /// 收件人市話區碼
  @JsonKey(name: 'post_area_code')
  String? area;

  /// 收件人市話
  @JsonKey(name: 'post_tel')
  String? tel;

  /// 收件人市話分機號碼
  @JsonKey(name: 'post_tel_ext')
  String? ext;

  String get sensitivePhone {
    return '+$area-${tel?.replaceRange(2, 7, '** **')} # $ext';
  }

  /// 收件人郵遞區號
  @JsonKey(name: 'post_zipcode')
  String? zipCode;

  /// 收件人縣市
  @JsonKey(name: 'post_city')
  String? county;

  /// 收件人鄉鎮
  @JsonKey(name: 'post_state')
  String? district;

  /// 收件人地址
  @JsonKey(name: 'post_address')
  String? address;

  String get sensitiveAddress {
    return '$zipCode $county$district ${address?.replaceRange(6, null, '*****')}';
  }

  @JsonKey(
      name: 'is_default',
      fromJson: JsonValueConverter.boolFromInt,
      toJson: JsonValueConverter.boolToInt)
  bool isDefault;

  factory ShippingInfo.fromJson(Map<String, dynamic> json) =>
      _$ShippingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingInfoToJson(this);
}
