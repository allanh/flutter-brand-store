import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../repositories/member/invoice_setting_repository.dart';

class GetInvoiceSettingUseCase extends UseCase<GetInvoiceSettingUseCaseResponse,
    GetInvoiceSettingUseCaseParams> {
  final InvoiceSettingRepository repo;
  GetInvoiceSettingUseCase(this.repo);

  @override
  Future<Stream<GetInvoiceSettingUseCaseResponse?>> buildUseCaseStream(
      GetInvoiceSettingUseCaseParams? params) async {
    final controller = StreamController<GetInvoiceSettingUseCaseResponse>();

    try {
      // get member history products
      final invoices = await repo.getInvoiceSetting();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(GetInvoiceSettingUseCaseResponse(invoices));
      logger.finest('GetMemberHistoryProductsUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetMemberHistoryProductsUseCase failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetInvoiceSettingUseCaseResponse {
  dynamic invoices;
  GetInvoiceSettingUseCaseResponse(invoices);
}

class GetInvoiceSettingUseCaseParams {
  GetInvoiceSettingUseCaseParams();
}
