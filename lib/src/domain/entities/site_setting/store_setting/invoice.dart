import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

// Invoice
@JsonSerializable()
class InvoiceSystemInfo {
  InvoiceSystemInfo(this.businessNo, this.name, this.agree);

  @JsonKey(name: 'unified_business_no')
  final String businessNo;
  @JsonKey(name: 'company_name')
  final String name;
  @JsonKey(name: 'is_agree')
  final bool agree;

  factory InvoiceSystemInfo.fromJson(Map<String, dynamic> json) => _$InvoiceSystemInfoFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceSystemInfoToJson(this);
}
enum InvoiceType {
  @JsonValue(1) system,
  @JsonValue(2) self,
  @JsonValue(3) udi,
}
@JsonSerializable()
class InvoiceInfo {
  InvoiceInfo(this.type, this.systemInfo);
  static InvoiceInfo get empty {
    return InvoiceInfo(InvoiceType.udi, null);
  }

  final InvoiceType type;
  final InvoiceSystemInfo? systemInfo;

  factory InvoiceInfo.fromJson(Map<String, dynamic> json) => _$InvoiceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceInfoToJson(this);
}
@JsonSerializable()
class Charity {
  Charity(this.id, this.enabled, this.title, this.code, this.alias, this.county, this.key);

  @JsonKey(name: 'charity_id')
  final int id;
  @JsonKey(name: 'is_enable')
  final bool enabled;
  @JsonKey(name: 'display_name')
  final String title;
  @JsonKey(name: 'code')
  final String code;
  @JsonKey(name: 'alias_name')
  final String alias;
  final String county;
  final int key;

  factory Charity.fromJson(Map<String, dynamic> json) => _$CharityFromJson(json);
  Map<String, dynamic> toJson() => _$CharityToJson(this);
}
@JsonSerializable()
class Invoice {
  Invoice(this.info, this.charities);
  static Invoice get empty {
    return Invoice(InvoiceInfo.empty, []);
  }

  @JsonKey(name: 'invoice')
  InvoiceInfo info;
  @JsonKey(name: 'charity')
  List<Charity> charities;

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}
