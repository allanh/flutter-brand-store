abstract class InvoiceSettingRepository {
  Future<dynamic> getInvoiceSetting();

  Future<dynamic> submitDonationCode(code);
}
