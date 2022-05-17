import 'package:json_annotation/json_annotation.dart';

import '../link.dart';

part 'product_list_item.g.dart';

@JsonSerializable()
class ProductListItem {
  ProductListItem(this.image, this.name, this.price, this.recommend, this.link);

  @JsonKey(name: 'prod_image')
  String? image;
  @JsonKey(name: 'prod_name')
  String name;
  @JsonKey(name: 'prod_price')
  int price;
  @JsonKey(name: 'prod_recom')
  String? recommend;
  Link link;

  factory ProductListItem.fromJson(Map<String, dynamic> json) =>
      _$ProductListItemFromJson(json);
  Map<String, dynamic> toJson() => _$ProductListItemToJson(this);
}
