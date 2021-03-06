import 'package:json_annotation/json_annotation.dart';
part 'link.g.dart';

enum LinkType {
  @JsonValue('')
  none,
  @JsonValue('product')
  product,
  @JsonValue('inputurl')
  url,
  @JsonValue('selcategory')
  category,
  @JsonValue('selcategoryview')
  categoryView,
  @JsonValue('neweventview')
  neweventview,
  @JsonValue('cart')
  cart,
  @JsonValue('orderlist')
  order,
  @JsonValue('favorite')
  favorite,
  @JsonValue('bought')
  bought,
  @JsonValue('cookie')
  cookie,
  @JsonValue('updatemember')
  updatemember,
  @JsonValue('fastcheckout')
  fastcheckout,
  @JsonValue('orderqa')
  orderqa,
  @JsonValue('service')
  service,
  @JsonValue('membersetting')
  membersetting,
  @JsonValue('orderdetail')
  orderdetail,
  @JsonValue('newevent')
  allEvent,
  @JsonValue('neweventview')
  event,
  @JsonValue('coupon')
  coupon
}

@JsonSerializable()
class Link {
  Link(this.type, this.value);

  final LinkType type;
  final dynamic value;

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
