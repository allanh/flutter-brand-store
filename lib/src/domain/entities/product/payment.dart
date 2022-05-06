import 'package:json_annotation/json_annotation.dart';
part 'payment.g.dart';

@JsonSerializable()
class Payment {
  Atm? atm;
  Credit? credit;

  Payment({this.atm, this.credit});

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}

@JsonSerializable()
class Atm {
  @JsonKey(name: 'is_enable')
  bool? isEnable;

  Atm({this.isEnable});

  factory Atm.fromJson(Map<String, dynamic> json) => _$AtmFromJson(json);
  Map<String, dynamic> toJson() => _$AtmToJson(this);
}

@JsonSerializable()
class Credit {
  @JsonKey(name: 'is_enable')
  bool? isEnable;
  @JsonKey(name: 'is_bonus')
  bool? isBonus;
  @JsonKey(name: 'staging_info')
  List<StagingInfo>? stagingInfo;
  @JsonKey(name: 'is_staging')
  bool? isStaging;

  Credit({this.isEnable, this.isBonus, this.stagingInfo, this.isStaging});

  factory Credit.fromJson(Map<String, dynamic> json) => _$CreditFromJson(json);
  Map<String, dynamic> toJson() => _$CreditToJson(this);
}

@JsonSerializable()
class StagingInfo {
  double? fee;
  int? stage;
  @JsonKey(name: 'is_interest')
  bool? isInterest;
  @JsonKey(name: 'monthly_pay')
  int? monthlyPay;
  @JsonKey(name: 'bank_list')
  List<String>? bankList;

  StagingInfo(
      {this.fee, this.stage, this.isInterest, this.monthlyPay, this.bankList});

  factory StagingInfo.fromJson(Map<String, dynamic> json) =>
      _$StagingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$StagingInfoToJson(this);
}

@JsonSerializable()
class BonusBankInfo {
  int? stage;
  bool? interest;
  @JsonKey(name: 'bank_list')
  List<String>? bankList;

  BonusBankInfo({this.stage, this.interest, this.bankList});

  factory BonusBankInfo.fromJson(Map<String, dynamic> json) =>
      _$BonusBankInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BonusBankInfoToJson(this);
}
