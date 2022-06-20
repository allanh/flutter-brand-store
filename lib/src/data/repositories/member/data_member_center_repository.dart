import 'package:brandstores/src/data/utils/dio/dio_utils.dart';
import 'package:brandstores/src/domain/entities/member/member_center.dart';
import 'package:brandstores/src/domain/repositories/member/member_center_repository.dart';
import 'package:brandstores/src/data/utils/dio/api.dart';
import 'package:flutter/material.dart';

class DataMemberCenterRepository extends MemberCenterRepository {
  // sigleton
  static final DataMemberCenterRepository _instance =
      DataMemberCenterRepository._internal();
  DataMemberCenterRepository._internal();
  factory DataMemberCenterRepository() => _instance;

  @override
  Future<MemberCenter> getMemberCenter() async {
    try {
      final response = await HttpUtils.instance.get(Api.memberCenter);
      if (response.isSuccess) {
        return MemberCenter.fromJson(response.data);
      }
      throw Exception('Failed to get member center.');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to get member center.');
    }
  }
}
