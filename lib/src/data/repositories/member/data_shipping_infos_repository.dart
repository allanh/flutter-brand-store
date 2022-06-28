import 'package:brandstores/src/domain/repositories/member/shipping_infos_repository.dart';
import 'package:flutter/material.dart';
import 'package:brandstores/src/data/utils/dio/dio_utils.dart';
import 'package:brandstores/src/data/utils/dio/api.dart';

import '../../../domain/entities/member/shipping_info.dart';

class DataShippingInfosRepository extends ShippingInfosRepository {
  static final DataShippingInfosRepository _instance =
      DataShippingInfosRepository._internal();

  DataShippingInfosRepository._internal();
  factory DataShippingInfosRepository() => _instance;

  @override
  Future getShippingInfos() async {
    try {
      final response = await HttpUtils.instance.get(Api.shippingInfo);
      if (response.isSuccess) {
        return ShippingInfoResponse.fromJson(response.data);
      }
      throw Exception('Failed to get shipping info.');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to get shipping info.');
    }
  }
}
