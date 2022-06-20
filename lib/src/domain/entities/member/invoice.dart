import 'package:json_annotation/json_annotation.dart';

import '../../../data/helper/json_value_converter.dart';

part 'invoice.g.dart';

@JsonSerializable()
class InvoicesResponse {
  InvoicesResponse(
    this.id,
    this.status,
    this.message,
    this.invoices,
  );

  final String id;
  final String status;
  final String? message;

  @JsonKey(name: 'data')
  final InvoicesInfo invoices;

  factory InvoicesResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoicesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InvoicesResponseToJson(this);
}

@JsonSerializable()
class InvoicesInfo {
  InvoicesInfo(
    this.membershipCarrier,
    this.donationNPO,
    this.mobileCarrier,
    this.vatCarrier,
    this.citizenDigitalCarrier,
  );

  /// 會員載具
  @JsonKey(name: 'personal_member')
  late MembershipCarrier? membershipCarrier;

  /// 愛心捐贈
  @JsonKey(name: 'donation')
  late DonationNPO? donationNPO;

  /// 手機條碼載具
  @JsonKey(name: 'personal_mobile')
  late MobileCarrier? mobileCarrier;

  /// 公司-三聯式電子發票
  @JsonKey(name: 'company')
  late ValueAddedTaxCarrier? vatCarrier;

  /// 個人-自然人憑證
  @JsonKey(name: 'personal_citizen')
  late CitizenDigitalCarrier? citizenDigitalCarrier;

  List<dynamic> get carriers => <dynamic>[
        membershipCarrier,
        mobileCarrier,
        citizenDigitalCarrier,
        vatCarrier,
        donationNPO,
      ];

  List<dynamic> validCarriers() {
    /// 如果有 id 則視為有效的載具
    List<dynamic> list = carriers.where((carrier) {
      return carrier != null &&
          (carrier as Carrier).id != null &&
          carrier.id!.isNotEmpty;
    }).toList();

    /// 因為會員載具沒有 id，只有 memberId
    /// 上面的邏輯不會將會員載具加入
    /// 因此，在這邊手凍僵會員載具加入陣列
    list.insert(0, membershipCarrier);

    return list;
  }

  factory InvoicesInfo.fromJson(Map<String, dynamic> json) =>
      _$InvoicesInfoFromJson(json);
  Map<String, dynamic> toJson() => _$InvoicesInfoToJson(this);
}

/// 個人-自然人憑證
@JsonSerializable()
class CitizenDigitalCarrier implements Carrier {
  CitizenDigitalCarrier(
    this.type,
    this.id,
    this.carrierId,
    this.isDefault,
  );

  @override
  CarrierType? type = CarrierType.citizenDigitalCarrier;

  /// 流水號
  @override
  @JsonKey(name: 'main_id')
  String? id;

  /// 載具號碼(自然人憑證)
  @JsonKey(name: 'carrier_no_person')
  @override
  String? carrierId;

  /// 是否是預設發票
  @override
  @JsonKey(
    name: 'is_default',
    fromJson: JsonValueConverter.boolFromInt,
    toJson: JsonValueConverter.boolToInt,
  )
  bool isDefault;

  factory CitizenDigitalCarrier.fromJson(Map<String, dynamic> json) =>
      _$CitizenDigitalCarrierFromJson(json);
  Map<String, dynamic> toJson() => _$CitizenDigitalCarrierToJson(this);
}

@JsonSerializable()

/// 公司-三聯式電子發票
class ValueAddedTaxCarrier implements Carrier {
  ValueAddedTaxCarrier(
    this.type,
    this.id,
    this.carrierId,
    this.title,
    this.isDefault,
  );

  @override
  CarrierType? type = CarrierType.valueAddedTaxCarrier;

  /// 流水號
  @override
  @JsonKey(name: 'main_id')
  String? id;

  /// 統一編號
  @override
  @JsonKey(name: 'vat_no')
  String? carrierId;

  /// 發票抬頭
  @JsonKey(name: 'vat_title')
  String? title;

  /// 是否是預設發票
  @override
  @JsonKey(
    name: 'is_default',
    fromJson: JsonValueConverter.boolFromInt,
    toJson: JsonValueConverter.boolToInt,
  )
  bool isDefault;

  factory ValueAddedTaxCarrier.fromJson(Map<String, dynamic> json) =>
      _$ValueAddedTaxCarrierFromJson(json);
  Map<String, dynamic> toJson() => _$ValueAddedTaxCarrierToJson(this);
}

@JsonSerializable()

/// 手機條碼載具
class MobileCarrier implements Carrier {
  MobileCarrier(
    this.type,
    this.id,
    this.carrierId,
    this.isDefault,
  );

  @override
  CarrierType? type = CarrierType.mobileCarrier;

  /// 流水號
  @override
  @JsonKey(name: 'main_id')
  String? id;

  @override
  @JsonKey(name: 'carrier_no')
  String? carrierId;

  /// 是否是預設發票
  @override
  @JsonKey(
    name: 'is_default',
    fromJson: JsonValueConverter.boolFromInt,
    toJson: JsonValueConverter.boolToInt,
  )
  bool isDefault;

  factory MobileCarrier.fromJson(Map<String, dynamic> json) =>
      _$MobileCarrierFromJson(json);
  Map<String, dynamic> toJson() => _$MobileCarrierToJson(this);
}

@JsonSerializable()

/// 會員載具
class MembershipCarrier implements Carrier {
  MembershipCarrier(
    this.type,
    this.id,
    this.carrierId,
    this.isDefault,
  );

  @override
  CarrierType? type = CarrierType.membershipCarrier;

  /// 流水號
  @override
  String? id;

  /// 會員id
  @JsonKey(name: 'member_id')
  int? memberId;

  @override
  String? carrierId;

  /// 是否是預設發票
  @override
  @JsonKey(
    name: 'is_default',
    fromJson: JsonValueConverter.boolFromInt,
    toJson: JsonValueConverter.boolToInt,
  )
  bool isDefault;

  factory MembershipCarrier.fromJson(Map<String, dynamic> json) =>
      _$MembershipCarrierFromJson(json);
  Map<String, dynamic> toJson() => _$MembershipCarrierToJson(this);
}

@JsonSerializable()

/// 愛心捐贈
class DonationNPO implements Carrier {
  DonationNPO(
    this.type,
    this.id,
    this.carrierId,
    this.npos,
    this.isDefault,
  );

  @override
  CarrierType? type = CarrierType.donate;

  /// 流水號
  @override
  String? id;

  @override
  String? carrierId;

  @JsonKey(name: 'donation_npoban')
  List<NPO>? npos;

  /// 是否是預設發票
  @override
  @JsonKey(
    name: 'is_default',
    fromJson: JsonValueConverter.boolFromInt,
    toJson: JsonValueConverter.boolToInt,
  )
  bool isDefault;

  factory DonationNPO.fromJson(Map<String, dynamic> json) =>
      _$DonationNPOFromJson(json);
  Map<String, dynamic> toJson() => _$DonationNPOToJson(this);
}

@JsonSerializable()

/// 非營利機構(NonprofitOrganization)
class NPO {
  NPO(
    this.npoId,
    this.title,
    this.isEnabled,
  );

  /// 愛心碼
  @JsonKey(name: 'npoban')
  String? npoId;

  /// 發票抬頭
  @JsonKey(name: 'npoban_name')
  String? title;

  /// 是否為預設選項
  @JsonKey(
    name: 'is_enabled',
    fromJson: JsonValueConverter.boolFromInt,
    toJson: JsonValueConverter.boolToInt,
  )
  bool isEnabled;

  factory NPO.fromJson(Map<String, dynamic> json) => _$NPOFromJson(json);
  Map<String, dynamic> toJson() => _$NPOToJson(this);
}

enum CarrierType {
  membershipCarrier,
  mobileCarrier,
  citizenDigitalCarrier,
  valueAddedTaxCarrier,
  donate,
}

abstract class Carrier {
  /// 載具類型
  CarrierType? type;

  /// 流水號
  String? id = '';

  /// 載具號碼
  String? carrierId;

  /// 是否是預設發票
  late bool isDefault;
}

// class Carrier {
//   Carrier(
//     this.type,
//     this.id,
//     this.carrierId,
//     this.isDefault,
//   );

//   /// 載具類型
//   CarrierType? type;

//   /// 流水號
//   @JsonKey(name: 'main_id')
//   String? id;

//   /// 載具號碼
//   String? carrierId;

//   /// 是否是預設發票
//   @JsonKey(
//     name: 'is_default',
//     fromJson: JsonValueConverter.boolFromInt,
//     toJson: JsonValueConverter.boolToInt,
//   )
//   bool isDefault;
// }
