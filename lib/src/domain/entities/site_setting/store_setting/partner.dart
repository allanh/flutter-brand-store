// Partner
import 'package:json_annotation/json_annotation.dart';

part 'partner.g.dart';

@JsonSerializable()
class Partner {
  Partner(this.beginDate);
  static Partner get empty {
    return Partner(DateTime.now());
  }

  @JsonKey(name: 'begin_date')
  final DateTime beginDate;

  factory Partner.fromJson(Map<String, dynamic> json) => _$PartnerFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerToJson(this);
}
