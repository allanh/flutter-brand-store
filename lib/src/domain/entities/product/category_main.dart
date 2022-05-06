import 'package:json_annotation/json_annotation.dart';
part 'category_main.g.dart';

@JsonSerializable()
class CategoryLevel {
  @JsonKey(name: 'category_id')
  String? categoryId;
  @JsonKey(name: 'category_name')
  String? categoryName;

  CategoryLevel({this.categoryId, this.categoryName});

  factory CategoryLevel.fromJson(Map<String, dynamic> json) =>
      _$CategoryLevelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryLevelToJson(this);
}

@JsonSerializable()
class CategoryMain {
  @JsonKey(name: 'category_id')
  int? categoryId;
  @JsonKey(name: 'category_path')
  String? categoryPath;
  @JsonKey(name: 'category_path_name')
  String? categoryPathName;
  String? name;
  int? status;
  String? slogan;
  @JsonKey(name: 'slogan_link')
  String? sloganLink;
  @JsonKey(name: 'slogan_started_at')
  String? sloganStartedAt;
  @JsonKey(name: 'slogan_ended_at')
  String? sloganEndedAt;
  @JsonKey(name: 'category_level')
  List<CategoryLevel>? categoryLevel;

  CategoryMain(
      {this.categoryId,
      this.categoryPath,
      this.categoryPathName,
      this.name,
      this.status,
      this.slogan,
      this.sloganLink,
      this.sloganStartedAt,
      this.sloganEndedAt,
      this.categoryLevel});

  factory CategoryMain.fromJson(Map<String, dynamic> json) =>
      _$CategoryMainFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryMainToJson(this);
}
