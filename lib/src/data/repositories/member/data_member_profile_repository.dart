import 'package:brandstores/src/data/utils/dio/base_res.dart';
import 'package:brandstores/src/data/utils/dio/dio_utils.dart';
import 'package:brandstores/src/domain/entities/member/member_profile.dart';
import 'package:brandstores/src/domain/repositories/member/member_profile_repository.dart';
import 'package:brandstores/src/data/utils/dio/api.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class DataMemberProfileRepository extends MemberProfileRepository {
  // sigleton
  static final DataMemberProfileRepository _instance =
      DataMemberProfileRepository._internal();
  DataMemberProfileRepository._internal();
  factory DataMemberProfileRepository() => _instance;

  /// 取會員資料
  @override
  Future<MemberProfile> getMemberProfile() async {
    try {
      final response = await HttpUtils.instance.get(Api.memberProfile);
      if (response.isSuccess) {
        return MemberProfile.fromJson(response.data);
      }
      throw Exception('Failed to get member center.');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to get member center.');
    }
  }

  /// 門號驗證
  @override
  Future<VerificationResult> verifyMobile(
      String countryCode, String mobile) async {
    try {
      debugPrint('Country code: $countryCode\nMobile: $mobile');
      final response =
          await HttpUtils.instance.post(Api.memberVerification, params: {
        'mobile_code': countryCode,
        'mobile': mobile,
        "email": "",
        'verify_type': 'VERIFY_ACCOUNT'
      });
      if (response.isSuccess) {
        return VerificationResult.fromJson(response.data);
      }
      throw Exception('Failed to verify member.');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to verify member.');
    }
  }

  /// 下載郵遞區號
  @override
  Future<List<Districts>> loadDistricts() async {
    var jsonText = await rootBundle.loadString('assets/taiwan_districts.json');
    var decodedJson = json.decode(jsonText) as List;
    var city = List.generate(decodedJson.length, (index) {
      final list =
          List.generate(decodedJson[index]['districts'].length, (innerIndex) {
        final zip = decodedJson[index]['districts'][innerIndex]['zip'];
        final name = decodedJson[index]['districts'][innerIndex]['name'];
        final District district = District(zip, name);
        return district;
      });
      final name = decodedJson[index]['name'];
      final Districts districts = Districts(list, name);
      return districts;
    });
    return city;
  }

  /// 會員資料更新
  @override
  Future<BaseResponse> updateProfile(MemberProfile? profile) async {
    try {
      final response =
          await HttpUtils.instance.post(Api.updateProfile, params: {
        "name": profile?.name,
        "area_code": profile?.areaCode,
        "tel": profile?.phone,
        "tel_ext": profile?.ext,
        "gender": profile?.gender?.toGenderString(),
        "birth": profile?.birthday,
        "zip": profile?.zipCode,
        "cityno": profile?.county,
        "areano": profile?.district,
        "address": profile?.address
      });
      if (response.isSuccess) {
        return BaseResponse.fromJson(response);
      }
      throw Exception('Failed to get member center.');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to get member center.');
    }
  }
}
