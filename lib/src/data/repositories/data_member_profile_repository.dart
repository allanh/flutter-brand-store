import 'package:brandstores/src/data/utils/dio/dio_utils.dart';
import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';
import 'package:brandstores/src/domain/repositories/member_profile_repository.dart';
import 'package:brandstores/src/data/utils/dio/api.dart';
import 'package:flutter/material.dart';

class DataMemberProfileRepository extends MemberProfileRepository {
  // sigleton
  static final DataMemberProfileRepository _instance =
      DataMemberProfileRepository._internal();
  DataMemberProfileRepository._internal();
  factory DataMemberProfileRepository() => _instance;

  @override
  Future<MemberProfile> getMemberProfile() async {
    try {
      final response = await HttpUtils.instance.get(Api.memberCenter);
      if (response.isSuccess) {
        return MemberProfile.fromJson(response.data);
      }
      throw Exception('Failed to get member center.');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to get member center.');
    }
  }
}