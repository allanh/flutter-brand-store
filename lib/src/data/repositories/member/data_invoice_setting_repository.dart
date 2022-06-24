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
  Future submitDonationCode(id, code) async {
    dynamic params = {
      "invoice_type": "donation",
      "donation_npoban": [
        {
          "npoban_no": code,
          "npoban_name": '',
          "is_enabled": 1,
        }
      ],
      "is_default": 1
    };
    if (id != null) {
      params["main_id"] = id;
    }

    /// 有流水號(id)則呼叫更新載具的 API，反之，呼叫新增載具的 API
    String path = id == null ? Api.addCarrier : Api.updateCarrier;
    try {
      final response = await HttpUtils.instance.post(path, params: params);
      return response.isSuccess;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to add carrier.');
    }
  }

  @override
  Future submitMobileCarrier(id, carrier) async {
    dynamic params = {
      "invoice_type": "mobile",
      "carrier_no": carrier,
      "is_default": 0
    };
    if (id != null) {
      params["main_id"] = id;
    }

    /// 有流水號(id)則呼叫更新載具的 API，反之，呼叫新增載具的 API
    String path = id == null ? Api.addCarrier : Api.updateCarrier;
    try {
      final response = await HttpUtils.instance.post(path, params: params);
      return response.isSuccess;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to add carrier.');
    }
  }

  @override
  Future submitCitizenDigitalCarrier(id, carrierId) async {
    dynamic params = {
      "invoice_type": "citizen",
      "carrier_no_person": carrierId,
      "is_default": 0
    };
    if (id != null) {
      params["main_id"] = id;
    }

    /// 有流水號(id)則呼叫更新載具的 API，反之，呼叫新增載具的 API
    String path = id == null ? Api.addCarrier : Api.updateCarrier;
    try {
      final response = await HttpUtils.instance.post(path, params: params);
      return response.isSuccess;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to add carrier.');
    }
  }

  @override
  Future submitValueAddedTaxCarrier(id, carrierId, title) async {
    dynamic params = {
      "invoice_type": "company",
      "vat_no": carrierId,
      "vat_title":"title",
      "is_default": 0
    };
    if (id != null) {
      params["main_id"] = id;
    }

    /// 有流水號(id)則呼叫更新載具的 API，反之，呼叫新增載具的 API
    String path = id == null ? Api.addCarrier : Api.updateCarrier;
    try {
      final response = await HttpUtils.instance.post(path, params: params);
      return response.isSuccess;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to add carrier.');
    }
  }

  @override
  Future changeDefaultCarrier(type, id, carrierId, title) async {
    dynamic params = {"invoice_type": type.value, "is_default": 1};
    if (id != null) {
      params["main_id"] = id;
    }
    switch (type) {
      case CarrierType.membershipCarrier:
        break;
      case CarrierType.mobileCarrier:
        params["carrier_no"] = carrierId;
        break;
      case CarrierType.citizenDigitalCarrier:
        params["carrier_no_person"] = carrierId;
        break;
      case CarrierType.valueAddedTaxCarrier:
        params["vat_no"] = carrierId;
        params["vat_title"] = title;
        break;
      case CarrierType.donate:
        params['donation_npoban'] = [
          {
            "npoban_no": carrierId,
            "npoban_name": title,
            'is_enabled': 1,
          }
        ];
        break;
    }

    /// 有流水號(id)則呼叫更新載具的 API，反之，呼叫新增載具的 API
    String path = id == null ? Api.addCarrier : Api.updateCarrier;
    try {
      final response = await HttpUtils.instance.post(path, params: params);
      return response.isSuccess;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to update carrier.');
    }
  }
}
