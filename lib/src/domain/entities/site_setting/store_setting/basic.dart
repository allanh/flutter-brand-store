import 'package:json_annotation/json_annotation.dart';

import '../../../../data/helper/json_value_converter.dart';
import '../../address.dart';
import '../../sort_option.dart';

part 'basic.g.dart';

// Basic
@JsonSerializable()
class StoreInfo {
  StoreInfo(this.name, this.businessHour, this.phone, this.remark, this.address);
  static StoreInfo get empty {
    return StoreInfo('', '', '', '', Address.empty);
  }

  final String name;
  @JsonKey(name: 'business_hour')
  final String businessHour;
  @JsonKey(name: 'tel')
  final String phone;
  final String remark;
  final Address address;

  factory StoreInfo.fromJson(Map<String, dynamic> json) => _$StoreInfoFromJson(json);
  Map<String, dynamic> toJson() => _$StoreInfoToJson(this);

}
@JsonSerializable()
class Basic {
  Basic(this.name, this.company, this.businessNo, this.store, this.introduction, this.email, this.title, this.keywords, this.logoID, this.logoUrl, this.sort);
  static Basic get empty {
    return Basic('', '', '', StoreInfo.empty, '', '', '', '', 0, '', SortOptions.hot);
  }

  final String name;
  @JsonKey(name: 'company_name')
  final String company;
  @JsonKey(name: 'unified_business_no')
  final String businessNo;
  @JsonKey(name: 'store_info')
  final StoreInfo store;
  final String introduction;
  @JsonKey(name: 'cs_email')
  final String email;
  final String title;
  final String keywords;
  @JsonKey(name: 'logo_image_id')
  final int logoID;
  @JsonKey(name: 'logo_image')
  final String logoUrl;
  @JsonKey(name: 'category_sort', fromJson: JsonValueConverter.sortOptionsFromString, toJson: JsonValueConverter.sortOptionToString)
  final SortOptions sort;
  
  factory Basic.fromJson(Map<String, dynamic> json) => _$BasicFromJson(json);
  Map<String, dynamic> toJson() => _$BasicToJson(this);
}
