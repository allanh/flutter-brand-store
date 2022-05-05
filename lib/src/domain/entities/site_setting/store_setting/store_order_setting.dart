import 'package:json_annotation/json_annotation.dart';

part 'store_order_setting.g.dart';
// Order
@JsonSerializable()
class StoreOrderSetting {
  StoreOrderSetting(this.partialReturn, this.hesitate);
  static StoreOrderSetting get empty {
    return StoreOrderSetting(false, 0);
  }

  @JsonKey(name: 'partial_return')
  final bool partialReturn;
  @JsonKey(name: 'order_hesitate')
  final int hesitate;

  factory StoreOrderSetting.fromJson(Map<String, dynamic> json) => _$StoreOrderSettingFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderSettingToJson(this);
}
