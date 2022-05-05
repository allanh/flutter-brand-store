
import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  Address(this.zip, this.county, this.district, this.address);
  static Address get empty {
    return Address('', '', '', null);
  }

  @JsonKey(name: 'zipcode')
  final String zip;
  final String county;
  final String district;
  final String? address;
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
