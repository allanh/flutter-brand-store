import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

enum ResponseStatus {
  @JsonValue('SUCCESS') success,
  @JsonValue('FAILURE') failure
}
@JsonSerializable()
class Response {
  Response(this.id, this.message, this.status);
  String id;
  String? message;
  ResponseStatus status;
}