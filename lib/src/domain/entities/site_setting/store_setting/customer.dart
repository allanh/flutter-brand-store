import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

// Customer
@JsonSerializable()
class CustomerItem {
  CustomerItem(this.enabled);
  static CustomerItem get empty {
    return CustomerItem(false,);
  }

  @JsonKey(name: 'is_enable')
  final bool enabled;

  factory CustomerItem.fromJson(Map<String, dynamic> json) => _$CustomerItemFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerItemToJson(this);
}
@JsonSerializable()
class Customer {
  Customer(this.visitorBuy);
  static Customer get empty {
    return Customer(CustomerItem.empty,);
  }

  @JsonKey(name: 'visitor_buy')
  final CustomerItem visitorBuy;

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
