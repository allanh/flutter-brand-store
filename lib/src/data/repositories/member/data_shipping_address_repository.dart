import 'package:brandstores/src/domain/repositories/member/shipping_info_repository.dart';
import 'package:flutter/material.dart';
import 'package:brandstores/src/data/utils/dio/dio_utils.dart';
import 'package:brandstores/src/data/utils/dio/api.dart';

import '../../../domain/entities/member/shipping_info.dart';

class DataShippingAddressRepository extends ShippingAddressRepository {
  static final DataShippingAddressRepository _instance =
      DataShippingAddressRepository._internal();

  DataShippingAddressRepository._internal();
  factory DataShippingAddressRepository() => _instance;

  @override
  Future getShippingAddress() async {
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
