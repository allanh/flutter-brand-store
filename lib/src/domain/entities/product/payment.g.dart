// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      atm: json['atm'] == null
          ? null
          : Atm.fromJson(json['atm'] as Map<String, dynamic>),
      credit: json['credit'] == null
          ? null
          : Credit.fromJson(json['credit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'atm': instance.atm,
      'credit': instance.credit,
    };

Atm _$AtmFromJson(Map<String, dynamic> json) => Atm(
      isEnable: json['is_enable'] as bool?,
    );

Map<String, dynamic> _$AtmToJson(Atm instance) => <String, dynamic>{
      'is_enable': instance.isEnable,
    };

Credit _$CreditFromJson(Map<String, dynamic> json) => Credit(
      isEnable: json['is_enable'] as bool?,
      isBonus: json['is_bonus'] as bool?,
      stagingInfo: (json['staging_info'] as List<dynamic>?)
          ?.map((e) => StagingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      isStaging: json['is_staging'] as bool?,
    );

Map<String, dynamic> _$CreditToJson(Credit instance) => <String, dynamic>{
      'is_enable': instance.isEnable,
      'is_bonus': instance.isBonus,
      'staging_info': instance.stagingInfo,
      'is_staging': instance.isStaging,
    };

StagingInfo _$StagingInfoFromJson(Map<String, dynamic> json) => StagingInfo(
      fee: (json['fee'] as num?)?.toDouble(),
      stage: json['stage'] as int?,
      isInterest: json['is_interest'] as bool?,
      monthlyPay: json['monthly_pay'] as int?,
      bankList: (json['bank_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$StagingInfoToJson(StagingInfo instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'stage': instance.stage,
      'is_interest': instance.isInterest,
      'monthly_pay': instance.monthlyPay,
      'bank_list': instance.bankList,
    };

BonusBankInfo _$BonusBankInfoFromJson(Map<String, dynamic> json) =>
    BonusBankInfo(
      stage: json['stage'] as int?,
      interest: json['interest'] as bool?,
      bankList: (json['bank_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BonusBankInfoToJson(BonusBankInfo instance) =>
    <String, dynamic>{
      'stage': instance.stage,
      'interest': instance.interest,
      'bank_list': instance.bankList,
    };
