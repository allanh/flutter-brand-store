enum VerifyMethod {
  email,
  mobile,
  password // for 會員中心-修改密碼
}

extension VerifyMothodExtension on VerifyMethod {
  String get value => name.toUpperCase();
}
