import 'package:brandstores/src/data/utils/dio/base_res.dart';
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
      final response = await HttpUtils.instance.get(Api.invoiceSetting);
      if (response.isSuccess) {
        return InvoicesInfo.fromJson(response.data);
      }
      throw Exception('Failed to get invoice setting.');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to get invoice setting.');
    }
  }

  @override
  Future submitDonationCode(code) async {
    try {
      final response = await HttpUtils.instance.post(Api.addCarrier, params: {
        "invoice_type": "donation",
        "donation_npoban": [
          {
            "npoban_no": code,
            "is_enabled": 1,
          }
        ],
        "is_default": 1
      });
      if (response.isSuccess) return BaseResponse.fromJson(response);
      throw Exception('Failed to add carrier.');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to add carrier.');
    }
  }
}
