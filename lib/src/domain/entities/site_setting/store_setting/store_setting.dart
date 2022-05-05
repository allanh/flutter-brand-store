
import 'package:json_annotation/json_annotation.dart';

import 'basic.dart';
import 'customer.dart';
import 'front_page.dart';
import 'invoice.dart';
import 'login.dart';
import 'partner.dart';
import 'payment.dart';
import 'store_app_setting.dart';
import 'store_order_setting.dart';
import 'third_party.dart';
import 'trace.dart';

part 'store_setting.g.dart';
// StoreSetting
@JsonSerializable()
class StoreSetting {
  StoreSetting(this.domain, this.partner, this.basic, this.frontPage, this.thirdParty, this.login, this.customer, this.payment, this.invoice, this.appSetting, this.order, this.trace);
  static StoreSetting get empty {
    return StoreSetting('', Partner.empty, Basic.empty, FrontPage.empty, ThirdParty.empty, Login.empty, Customer.empty, Payment.empty, Invoice.empty, StoreAppSetting.empty, StoreOrderSetting.empty, Trace.empty);
  }

  final String domain;
  final Partner partner;
  final Basic basic;
  @JsonKey(name: 'front_page')
  final FrontPage frontPage;
  @JsonKey(name: 'third_party')
  final ThirdParty thirdParty;
  final Login login;
  final Customer customer;
  final Payment payment;
  final Invoice invoice;
  @JsonKey(name: 'app')
  final StoreAppSetting appSetting;
  final StoreOrderSetting order;
  @JsonKey(name: 'tracing_code')
  final Trace trace;
  
  factory StoreSetting.fromJson(Map<String, dynamic> json) => _$StoreSettingFromJson(json);
  Map<String, dynamic> toJson() => _$StoreSettingToJson(this);
}
