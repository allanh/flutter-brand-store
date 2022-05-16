import 'package:json_annotation/json_annotation.dart';
part 'event.g.dart';

@JsonSerializable()
class Event {
  @JsonKey(name: 'available_type')
  String? availableType;
  @JsonKey(name: 'event_id')
  int? eventId;
  @JsonKey(name: 'event_no')
  String? eventNo;
  @JsonKey(name: 'event_online')
  bool? eventOnline;
  String? type;
  String? name;
  String? description;
  @JsonKey(name: 'started_at')
  String? startedAt;
  @JsonKey(name: 'ended_at')
  String? endedAt;
  @JsonKey(name: 'is_used_limit')
  bool? isUsedLimit;
  @JsonKey(name: 'rule_type')
  String? ruleType;
  @JsonKey(name: 'rule_content')
  String? ruleContent;
  @JsonKey(name: 'rule_infos')
  List<RuleInfos>? ruleInfos;

  Event(
      {this.availableType,
      this.eventId,
      this.eventNo,
      this.eventOnline,
      this.type,
      this.name,
      this.description,
      this.startedAt,
      this.endedAt,
      this.isUsedLimit,
      this.ruleType,
      this.ruleContent,
      this.ruleInfos});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable()
class RuleInfos {
  @JsonKey(name: 'rule_info')
  List<RuleInfo>? ruleInfo;

  RuleInfos({this.ruleInfo});

  factory RuleInfos.fromJson(Map<String, dynamic> json) =>
      _$RuleInfosFromJson(json);
  Map<String, dynamic> toJson() => _$RuleInfosToJson(this);
}

@JsonSerializable()
class RuleInfo {
  @JsonKey(name: 'per_price')
  int? perPrice;
  @JsonKey(name: 'per_unit')
  int? perUnit;
  int? discount;
  @JsonKey(name: 'fixed_price')
  int? fixedPrice;

  RuleInfo({this.perPrice, this.perUnit, this.discount, this.fixedPrice});

  factory RuleInfo.fromJson(Map<String, dynamic> json) =>
      _$RuleInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RuleInfoToJson(this);
}
