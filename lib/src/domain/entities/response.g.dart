// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      json['id'] as String,
      json['message'] as String?,
      $enumDecode(_$ResponseStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'status': _$ResponseStatusEnumMap[instance.status],
    };

const _$ResponseStatusEnumMap = {
  ResponseStatus.success: 'SUCCESS',
  ResponseStatus.failure: 'FAILURE',
};
