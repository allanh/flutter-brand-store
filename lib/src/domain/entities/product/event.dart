import 'package:json_annotation/json_annotation.dart';
part 'event.g.dart';

/// 活動適⽤類型
enum EventType {
  @JsonValue('EVENT_DISCOUNT')
  eventDiscount, // 促銷折扣
}

/// 活動適⽤類型
enum AvailableType {
  @JsonValue('ALL')
  all, // 全站活動
  @JsonValue('PRODUCT')
  product, // 指定商品
}

/// 折扣條件
enum RuleType {
  @JsonValue('NO_RULES')
  noRules, // 無條件
  @JsonValue('FILL_UP')
  fillUp, // 滿件折扣
  @JsonValue('EACH_FILL_UP')
  eachFillUp, // 每滿件
  @JsonValue('OVER_AMOUNT')
  overAmount, // 滿額
  @JsonValue('EACH_OVER_AMOUNT')
  eachOverAmount, // 每滿額
  @JsonValue('FILL_UP_MULTI')
  fillUpMulti, // 滿件級距
  @JsonValue('OVER_AMOUNT_MULTI')
  overAmountMulti, // 滿額級距
}

/// 折扣條件
enum RuleContent {
  @JsonValue('ORDER_DISCOUNT')
  orderDiscount, // 訂單⾦額折N元
  @JsonValue('PRODUCT_PERCENT_OFF')
  productPercentOff, // 所有適⽤商品打N折
  @JsonValue('PRODUCT_FIXED_PRICE')
  productFixedPrice, // 所有適⽤商品每件固定N元
  @JsonValue('PRODUCT_DISCOUNT')
  productDiscount, // 所有適⽤商品每件折N元
  @JsonValue('GIVE_FREEBIE')
  giveFreebie, // 贈送贈品
}

@JsonSerializable()
class Event {
  @JsonKey(name: 'available_type')
  AvailableType? availableType;
  @JsonKey(name: 'event_id')
  int? eventId;
  @JsonKey(name: 'event_no')
  String? eventNo;
  @JsonKey(name: 'event_online')
  bool? eventOnline;
  EventType? type;
  String? name;
  String? description;
  @JsonKey(name: 'started_at')
  String? startedAt;
  @JsonKey(name: 'ended_at')
  String? endedAt;
  @JsonKey(name: 'is_used_limit')
  bool? isUsedLimit;
  @JsonKey(name: 'rule_type')
  RuleType? ruleType;
  @JsonKey(name: 'rule_content')
  RuleContent? ruleContent;
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
