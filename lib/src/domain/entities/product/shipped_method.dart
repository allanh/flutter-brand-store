import 'package:json_annotation/json_annotation.dart';
import 'range_info.dart';
part 'shipped_method.g.dart';

@JsonSerializable()
class ShippedMethod {
  String? type;
  @JsonKey(name: 'temperature_layer')
  String? temperatureLayer;
  @JsonKey(name: 'shipping_name')
  String? shippingName;
  @JsonKey(name: 'display_name')
  String? displayName;
  @JsonKey(name: 'main_is_enabled')
  bool? mainIsEnabled;
  @JsonKey(name: 'cost_type')
  String? costType;
  @JsonKey(name: 'fixed_cost')
  int? fixedCost;
  @JsonKey(name: 'range_info')
  RangeInfo? rangeInfo;
  @JsonKey(name: 'outlying_is_enabled')
  bool? outlyingIsEnabled;
  @JsonKey(name: 'outlying_cost_type')
  String? outlyingCostType;
  @JsonKey(name: 'outlying_fixed_cost')
  int? outlyingFixedCost;
  @JsonKey(name: 'outlying_range_info')
  String? outlyingRangeInfo;

  ShippedMethod(
      {this.type,
      this.temperatureLayer,
      this.shippingName,
      this.displayName,
      this.mainIsEnabled,
      this.costType,
      this.fixedCost,
      this.rangeInfo,
      this.outlyingIsEnabled,
      this.outlyingCostType,
      this.outlyingFixedCost,
      this.outlyingRangeInfo});

  factory ShippedMethod.fromJson(Map<String, dynamic> json) =>
      _$ShippedMethodFromJson(json);
  Map<String, dynamic> toJson() => _$ShippedMethodToJson(this);
}
