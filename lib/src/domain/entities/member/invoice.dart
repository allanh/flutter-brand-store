import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

@JsonSerializable()
class InvoicesResponse {
  InvoicesResponse();
  factory InvoicesResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoicesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InvoicesResponseToJson(this);
}
