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
      final response = await repo.submitDonationCode(params?.id, params!.code);
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
  final bool result;
  SubmitDonationCodeUseCaseResponse(this.result);
}

class SubmitDonationCodeUseCaseParams {
  String? id;
  String code;
  SubmitDonationCodeUseCaseParams(this.id, this.code);
}

class SubmitMobileCarrierUseCase extends UseCase<
    SubmitMobileCarrierUseCaseResponse, SubmitMobileCarrierUseCaseParams> {
  final InvoiceSettingRepository repo;
  SubmitMobileCarrierUseCase(this.repo);

  @override
  Future<Stream<SubmitMobileCarrierUseCaseResponse?>> buildUseCaseStream(
      SubmitMobileCarrierUseCaseParams? params) async {
    final controller = StreamController<SubmitMobileCarrierUseCaseResponse>();

    try {
      // Submit mobile carrier.
      final response =
          await repo.submitMobileCarrier(params?.id, params!.carrier);
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(SubmitMobileCarrierUseCaseResponse(response));
      logger.finest('SubmitMobileCarrierUseCaseResponse successful.');
      controller.close();
    } catch (e) {
      logger.severe('SubmitMobileCarrierUseCaseResponse failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class SubmitMobileCarrierUseCaseResponse {
  final bool result;
  SubmitMobileCarrierUseCaseResponse(this.result);
}

class SubmitMobileCarrierUseCaseParams {
  String? id;
  String carrier;
  SubmitMobileCarrierUseCaseParams(this.id, this.carrier);
}

class SubmitCitizenDigitalCarrierUseCase extends UseCase<
    SubmitCitizenDigitalCarrierUseCaseResponse,
    SubmitCitizenDigitalCarrierUseCaseParams> {
  final InvoiceSettingRepository repo;
  SubmitCitizenDigitalCarrierUseCase(this.repo);

  @override
  Future<Stream<SubmitCitizenDigitalCarrierUseCaseResponse?>>
      buildUseCaseStream(
          SubmitCitizenDigitalCarrierUseCaseParams? params) async {
    final controller =
        StreamController<SubmitCitizenDigitalCarrierUseCaseResponse>();

    try {
      // Submit citizen digital carrier.
      final response =
          await repo.submitCitizenDigitalCarrier(params?.id, params!.carrier);
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(SubmitCitizenDigitalCarrierUseCaseResponse(response));
      logger.finest('SubmitCitizenDigitalCarrierUseCaseResponse successful.');
      controller.close();
    } catch (e) {
      logger.severe('SubmitCitizenDigitalCarrierUseCaseResponse failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class SubmitCitizenDigitalCarrierUseCaseParams {
  String? id;
  String carrier;
  SubmitCitizenDigitalCarrierUseCaseParams(this.id, this.carrier);
}

class SubmitCitizenDigitalCarrierUseCaseResponse {
  final bool result;
  SubmitCitizenDigitalCarrierUseCaseResponse(this.result);
}

class ChangeDefaultCarrierUseCase extends UseCase<
    ChangeDefaultCarrierUseCaseResponse, ChangeDefaultCarrierUseCaseParams> {
  final InvoiceSettingRepository repo;
  ChangeDefaultCarrierUseCase(this.repo);

  @override
  Future<Stream<ChangeDefaultCarrierUseCaseResponse?>> buildUseCaseStream(
      ChangeDefaultCarrierUseCaseParams? params) async {
    final controller = StreamController<ChangeDefaultCarrierUseCaseResponse>();

    try {
      // Change default carrier.
      final response = await repo.changeDefaultCarrier(
        params!.type,
        params.id,
        params.carrierId,
        params.title,
      );
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(ChangeDefaultCarrierUseCaseResponse(response));
      logger.finest('ChangeDefaultCarrierUseCaseResponse successful.');
      controller.close();
    } catch (e) {
      logger.severe('ChangeDefaultCarrierUseCaseResponse failure.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class ChangeDefaultCarrierUseCaseResponse {
  final bool result;
  ChangeDefaultCarrierUseCaseResponse(this.result);
}

class ChangeDefaultCarrierUseCaseParams {
  CarrierType type;
  String? id;
  String? carrierId;
  String? title;
  ChangeDefaultCarrierUseCaseParams(
    this.type,
    this.id,
    this.carrierId,
    this.title,
  );
}
