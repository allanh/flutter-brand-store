// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryLevel _$CategoryLevelFromJson(Map<String, dynamic> json) =>
    CategoryLevel(
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
    );

Map<String, dynamic> _$CategoryLevelToJson(CategoryLevel instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
    };

CategoryMain _$CategoryMainFromJson(Map<String, dynamic> json) => CategoryMain(
      categoryId: json['category_id'] as int?,
      categoryPath: json['category_path'] as String?,
      categoryPathName: json['category_path_name'] as String?,
      name: json['name'] as String?,
      status: json['status'] as int?,
      slogan: json['slogan'] as String?,
      sloganLink: json['slogan_link'] as String?,
      sloganStartedAt: json['slogan_started_at'] as String?,
      sloganEndedAt: json['slogan_ended_at'] as String?,
      categoryLevel: (json['category_level'] as List<dynamic>?)
          ?.map((e) => CategoryLevel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryMainToJson(CategoryMain instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_path': instance.categoryPath,
      'category_path_name': instance.categoryPathName,
      'name': instance.name,
      'status': instance.status,
      'slogan': instance.slogan,
      'slogan_link': instance.sloganLink,
      'slogan_started_at': instance.sloganStartedAt,
      'slogan_ended_at': instance.sloganEndedAt,
      'category_level': instance.categoryLevel,
    };
