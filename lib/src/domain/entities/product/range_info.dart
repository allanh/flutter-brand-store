import 'package:json_annotation/json_annotation.dart';
part 'range_info.g.dart';

@JsonSerializable()
class RangeInfo {
  int? cost;
  @JsonKey(name: 'lower_limit')
  int? lowerLimit;
  @JsonKey(name: 'upper_limit')
  int? upperLimit;

  RangeInfo({this.cost, this.lowerLimit, this.upperLimit});

  factory RangeInfo.fromJson(Map<String, dynamic> json) =>
      _$RangeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RangeInfoToJson(this);
}
