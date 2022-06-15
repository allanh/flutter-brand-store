import 'package:brandstores/src/domain/repositories/member/invoice_setting_repository.dart';
import 'package:brandstores/src/data/utils/dio/api.dart';
import 'package:flutter/material.dart';
import 'package:brandstores/src/data/utils/dio/dio_utils.dart';

import '../../../domain/entities/member/invoice.dart';

class DataInvoiceSettingRepository extends InvoiceSettingRepository {
  static final DataInvoiceSettingRepository _instance =
      DataInvoiceSettingRepository._internal();
  DataInvoiceSettingRepository._internal();
  factory DataInvoiceSettingRepository() => _instance;

  @override
  Future getInvoiceSetting() async {
    try {
      final response = await HttpUtils.instance.get(Api.memberCenter);
      if (response.isSuccess) {
        return InvoicesResponse.fromJson(response.data);
      }
      throw Exception('Failed to get invoice setting.');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to get invoice setting.');
    }
  }
}
