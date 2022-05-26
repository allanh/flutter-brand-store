import 'package:brandstores/src/domain/entities/account/account_body.dart';

import '../../data/utils/dio/base_res.dart';
import '../entities/enum/verify_type.dart';

abstract class AccountRepository {
  Future<BaseResponse> login(
      String mobileCode, String mobile, String email, String password);

  Future<BaseResponse> sendVerification(
      VerifyType verifyType, String mobileCode, String mobile, String email);

  Future<BaseResponse> verifyMobileCode(VerifyType verifyType,
      String mobileCode, String mobile, String verifyCode);

  Future<BaseResponse> resetPassword(
      String mobileCode, String mobile, String email, String password);

  Future<bool> accountIsExist(String mobileCode, String mobile, String email);

  Future<BaseResponse> register(AccountBody accountBody);
}
