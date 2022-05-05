import 'package:json_annotation/json_annotation.dart';

part 'third_party.g.dart';

// ThirdParty
@JsonSerializable()
class ThirdParty {
  ThirdParty(this.facebook, this.line, this.youtube, this.instagram);
  static ThirdParty get empty {
    return ThirdParty(null, null, null, null);
  }
  
  final String? facebook;
  final String? line;
  final String? youtube;
  final String? instagram;

  factory ThirdParty.fromJson(Map<String, dynamic> json) => _$ThirdPartyFromJson(json);
  Map<String, dynamic> toJson() => _$ThirdPartyToJson(this);
}
