import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

// Payment
@JsonSerializable()
class StagingInfo {
  StagingInfo(this.stage, this.interest, this.defaultUsing, this.enabled, this.key);

  final int stage;
  final double interest;
  @JsonKey(name: 'is_default_product_use')
  final bool defaultUsing;
  @JsonKey(name: 'is_enable')
  final bool enabled;
  final String key;

  factory StagingInfo.fromJson(Map<String, dynamic> json) => _$StagingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$StagingInfoToJson(this);
}
@JsonSerializable()
class PaymentItem {
  PaymentItem(this.enabled, this.defaultUsing, this.title, this.bonusEnabled, this.staging);
  static PaymentItem get empty {
    return PaymentItem(false, false, null, null, null);
  }

  @JsonKey(name: 'is_enable')
  final bool enabled;
  @JsonKey(name: 'is_default_product_use')
  final bool defaultUsing;
  @JsonKey(name: 'display_name')
  final String? title;
  @JsonKey(name: 'is_bonus')
  final bool? bonusEnabled;
  @JsonKey(name: 'staging_info')
  final List<StagingInfo>? staging;

  factory PaymentItem.fromJson(Map<String, dynamic> json) => _$PaymentItemFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentItemToJson(this);
}
@JsonSerializable()
class Payment {
  Payment(this.credit, this.atm);
  static Payment get empty {
    return Payment(PaymentItem.empty, PaymentItem.empty);
  }

  @JsonKey(name: 'credit')
  final PaymentItem credit;
  @JsonKey(name: 'atm')
  final PaymentItem atm;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
