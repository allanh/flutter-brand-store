import 'package:json_annotation/json_annotation.dart';
import 'range_info.dart';
part 'shipped_method.g.dart';

/// 商品出貨種類
enum ShippedType {
  @JsonValue('NORMAL')
  normal, // 現貨商品
  @JsonValue('PREORDER')
  preorder, // 預購商品
  @JsonValue('CUSTOM')
  custom, // 訂制商品
  @JsonValue('CONTACT')
  contact, // 客約 (由廠商連絡)
}

/// 保存期限
enum Expiry {
  @JsonValue('EVER')
  ever, // 永久
  @JsonValue('EXPIRE')
  expire, // 有效期限
}

/// 保存期限單位
enum ExpireDateType {
  @JsonValue('DAY')
  day, // 天
  @JsonValue('MONTH')
  month, // ⽉
  @JsonValue('YEAR')
  year, // 年
}

/// 溫層
enum TemperatureLayer {
  @JsonValue('NORMAL')
  normal, // 常溫
  @JsonValue('FRIDGE')
  fridge, // 冷藏
  @JsonValue('FREEZE')
  freeze, // 冷凍
}

/// 配送類型
enum ShippingType {
  @JsonValue('HOME_DELIVERY')
  homeDelivery, // 宅配
  @JsonValue('SEVEN_PICK_UP')
  sevenPickUp, // 7-11
  @JsonValue('FAMILY_PICK_UP')
  familyPickUp, // 全家
  @JsonValue('LARGE_DELIVERY')
  largeDelivery, // 大材配送常溫
}

extension ShippingTypeExtension on ShippingType {
  String get name {
    switch (this) {
      case ShippingType.sevenPickUp:
        return '7-11';
      case ShippingType.familyPickUp:
        return '全家';
      case ShippingType.largeDelivery:
        return '大材配送常溫';
      default:
        return '宅配';
    }
  }
}

/// 溫層
enum CostType {
  @JsonValue('FREE')
  free, // 免運費
  @JsonValue('FIXED')
  fixed, // 固定運費
  @JsonValue('RANGE')
  range, // 級距運費
}

@JsonSerializable()
class ShippedMethod {
  ShippingType? type;
  @JsonKey(name: 'temperature_layer')
  TemperatureLayer? temperatureLayer;
  @JsonKey(name: 'shipping_name')
  String? shippingName;
  @JsonKey(name: 'display_name')
  String? displayName;
  @JsonKey(name: 'main_is_enabled')
  bool? mainIsEnabled;
  @JsonKey(name: 'cost_type')
  CostType? costType;
  @JsonKey(name: 'fixed_cost')
  int? fixedCost;
  @JsonKey(name: 'range_info')
  List<RangeInfo>? rangeInfo;
  @JsonKey(name: 'outlying_is_enabled')
  bool? outlyingIsEnabled;
  @JsonKey(name: 'outlying_cost_type')
  CostType? outlyingCostType;
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

  /// 本島或離島
  String get mainOrOutlying {
    if (mainIsEnabled == true && outlyingIsEnabled == true) {
      return '本島/離島';
    } else if (outlyingIsEnabled == true) {
      return '離島';
    }
    return '本島';
  }
}
