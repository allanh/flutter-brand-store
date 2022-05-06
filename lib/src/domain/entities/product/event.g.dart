// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      availableType: json['available_type'] as String?,
      eventId: json['event_id'] as int?,
      eventNo: json['event_no'] as String?,
      eventOnline: json['event_online'] as bool?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      startedAt: json['started_at'] as String?,
      endedAt: json['ended_at'] as String?,
      isUsedLimit: json['is_used_limit'] as bool?,
      ruleType: json['rule_type'] as String?,
      ruleContent: json['rule_content'] as String?,
      ruleInfos: (json['rule_infos'] as List<dynamic>?)
          ?.map((e) => RuleInfos.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'available_type': instance.availableType,
      'event_id': instance.eventId,
      'event_no': instance.eventNo,
      'event_online': instance.eventOnline,
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'started_at': instance.startedAt,
      'ended_at': instance.endedAt,
      'is_used_limit': instance.isUsedLimit,
      'rule_type': instance.ruleType,
      'rule_content': instance.ruleContent,
      'rule_infos': instance.ruleInfos,
    };

RuleInfos _$RuleInfosFromJson(Map<String, dynamic> json) => RuleInfos(
      ruleInfo: (json['rule_info'] as List<dynamic>?)
          ?.map((e) => RuleInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RuleInfosToJson(RuleInfos instance) => <String, dynamic>{
      'rule_info': instance.ruleInfo,
    };

RuleInfo _$RuleInfoFromJson(Map<String, dynamic> json) => RuleInfo(
      perPrice: json['per_price'] as int?,
      perUnit: json['per_unit'] as int?,
      discount: json['discount'] as int?,
      fixedPrice: json['fixed_price'] as int?,
    );

Map<String, dynamic> _$RuleInfoToJson(RuleInfo instance) => <String, dynamic>{
      'per_price': instance.perPrice,
      'per_unit': instance.perUnit,
      'discount': instance.discount,
      'fixed_price': instance.fixedPrice,
    };
