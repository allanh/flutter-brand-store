enum VerifyType {
  addMember,
  bundleOpenId,
  resetPassword,
  exchangeBundle,
  updateMobile,
  verifyAccount
}

// 驗證類型:
// ADD_MEMBER=新增會員,
// EXCHANGE_BUNDLE=門號更換第三方綁定,
// RESET_PASSWORD=重設密碼,
// BUNDLE_OPENID=綁定第三方 或 第一次註冊就使用第三方登入,
// UPDATE_MOBILE=更新門號,
// VERIFY_ACCOUNT=會員資料內驗證
extension VerifyTypeExtension on VerifyType {
  String get value {
    switch (this) {
      case VerifyType.addMember:
        return "ADD_MEMBER";
      case VerifyType.bundleOpenId:
        return "BUNDLE_OPENID";
      case VerifyType.resetPassword:
        return "RESET_PASSWORD";
      case VerifyType.exchangeBundle:
        return "EXCHANGE_BUNDLE";
      case VerifyType.updateMobile:
        return "UPDATE_MOBILE";
      case VerifyType.verifyAccount:
        return "VERIFY_ACCOUNT";
    }
  }
}

extension StringToVerifyTypeExtension on String {
  VerifyType get toVerifyType {
    for (var type in VerifyType.values) {
      if (this == type.value) return type;
    }
    return VerifyType.verifyAccount;
  }
}
