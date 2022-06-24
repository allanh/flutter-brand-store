import '../../entities/member/invoice.dart';

abstract class InvoiceSettingRepository {
  Future<dynamic> getInvoiceSetting();

  Future<dynamic> submitDonationCode(id, code);

  Future<dynamic> submitMobileCarrier(id, carrier);

  Future<dynamic> submitCitizenDigitalCarrier(id, carrierId);

  Future<dynamic> submitValueAddedTaxCarrier(id, carrierId, title);

  Future<dynamic> changeDefaultCarrier(CarrierType type, id, carrierId, title);
}
