import '../../entities/member/invoice.dart';

abstract class InvoiceSettingRepository {
  Future<dynamic> getInvoiceSetting();

  Future<dynamic> submitDonationCode(code);

  Future<dynamic> submitMobileCarrier(id, carrier);

  Future<dynamic> submitCitizenDigitalCarrier(id, carrierId);

  Future<dynamic> changeDefaultCarrier(CarrierType type, id, carrierId, title);
}
