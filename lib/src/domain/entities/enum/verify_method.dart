enum VerifyMethod {
  email,
  mobile
}

extension VerifyMothodExtension on VerifyMethod {
  String get value {
    switch (this) {
      case VerifyMethod.email:
        return "EMAIL";
      case VerifyMethod.mobile:
        return "MOBILE";
    }
  }
}
