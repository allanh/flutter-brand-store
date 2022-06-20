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
  final Invoices invoices;

  factory InvoicesResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoicesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InvoicesResponseToJson(this);
}

@JsonSerializable()
class Invoices {
  Invoices(
    this.membershipCarrier,
    this.donationNPO,
  );

  /// 會員載具
  @JsonKey(name: 'personal_member')
  MembershipCarrier? membershipCarrier;

  /// 愛心捐贈
  @JsonKey(name: 'donation')
  DonationNPO? donationNPO;

  /// 手機條碼載具
  @JsonKey(name: 'personal_mobile')
  MobileCarrier? mobileCarrier;

  /// 公司-三聯式電子發票
  @JsonKey(name: 'company')
  ValueAddedTaxCarrier? vatCarrier;

  /// 個人-自然人憑證
  @JsonKey(name: 'personal_citizen')
  CitizenDigitalCarrier? citizenDigitalCarrier;

  factory Invoices.fromJson(Map<String, dynamic> json) =>
      _$InvoicesFromJson(json);
  Map<String, dynamic> toJson() => _$InvoicesToJson(this);
}

/// 個人-自然人憑證
@JsonSerializable()
class CitizenDigitalCarrier {
  CitizenDigitalCarrier(
    this.id,
    this.carrierId,
    this.isDefault,
  );

  /// 流水號
  @JsonKey(name: 'main_id')
  String? id;

  /// 載具號碼(自然人憑證)
  @JsonKey(name: 'carrier_no_person')
  String? carrierId;

  /// 是否是預設發票
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
class ValueAddedTaxCarrier {
  ValueAddedTaxCarrier(
    this.id,
    this.vatId,
    this.title,
    this.isDefault,
  );

  /// 流水號
  @JsonKey(name: 'main_id')
  String? id;

  /// 統一編號
  @JsonKey(name: 'vat_no')
  String? vatId;

  /// 發票抬頭
  @JsonKey(name: 'vat_title')
  String? title;

  /// 是否是預設發票
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
class MobileCarrier {
  MobileCarrier(
    this.id,
    this.carrierId,
    this.isDefault,
  );

  /// 流水號
  @JsonKey(name: 'main_id')
  String? id;

  @JsonKey(name: 'carrier_no')
  String? carrierId;

  /// 是否是預設發票
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
class MembershipCarrier {
  MembershipCarrier(
    this.carrierId,
    this.isDefault,
  );

  /// 會員id
  @JsonKey(name: 'member_id')
  final int? carrierId;

  /// 是否是預設發票
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
class DonationNPO {
  DonationNPO(
    this.npos,
    this.isDefault,
  );

  @JsonKey(name: 'donation_npoban')
  List<NPO>? npos;

  /// 是否是預設發票
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

class Carrier {
  Carrier(
    this.type,
    this.carrierId,
    this.isDefault,
  );

  /// 載具類型
  CarrierType type;

  /// 流水號
  @JsonKey(name: 'main_id')
  String? id;

  /// 載具號碼
  String? carrierId;

  /// 是否是預設發票
  @JsonKey(
    name: 'is_default',
    fromJson: JsonValueConverter.boolFromInt,
    toJson: JsonValueConverter.boolToInt,
  )
  bool isDefault;
}
