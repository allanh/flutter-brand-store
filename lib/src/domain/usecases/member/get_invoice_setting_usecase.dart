import 'dart:async';

import 'package:brandstores/src/data/utils/dio/base_res.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/member/invoice.dart';
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
      // get member invoice setting
      final invoices = await repo.getInvoiceSetting();
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(GetInvoiceSettingUseCaseResponse(invoices));
      logger.finest('GetInvoiceSettingUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetInvoiceSettingUseCase failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetInvoiceSettingUseCaseResponse {
  final InvoicesInfo invoices;
  GetInvoiceSettingUseCaseResponse(this.invoices);
}

class GetInvoiceSettingUseCaseParams {
  GetInvoiceSettingUseCaseParams();
}

class SubmitDonationCodeUseCase extends UseCase<
    SubmitDonationCodeUseCaseResponse, SubmitDonationCodeUseCaseParams> {
  final InvoiceSettingRepository repo;
  SubmitDonationCodeUseCase(this.repo);

  @override
  Future<Stream<SubmitDonationCodeUseCaseResponse?>> buildUseCaseStream(
      SubmitDonationCodeUseCaseParams? params) async {
    final controller = StreamController<SubmitDonationCodeUseCaseResponse>();

    try {
      // Submit donation code.
      final response = await repo.submitDonationCode(params!.code);
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(SubmitDonationCodeUseCaseResponse(response));
      logger.finest('SubmitDonationCodeUseCaseResponse successful.');
      controller.close();
    } catch (e) {
      logger.severe('SubmitDonationCodeUseCaseResponse failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class SubmitDonationCodeUseCaseResponse {
  final BaseResponse response;
  SubmitDonationCodeUseCaseResponse(this.response);
}

class SubmitDonationCodeUseCaseParams {
  String code;
  SubmitDonationCodeUseCaseParams(this.code);
}
