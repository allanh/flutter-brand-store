import 'package:brandstores/src/domain/entities/account/account_body.dart';

import '../../data/utils/dio/base_res.dart';

abstract class AccountRepository {
  Future<BaseResponse> login(
      String mobileCode, String mobile, String email, String password);

  Future<dynamic> register(AccountBody accountBody);

  Future<bool> resetPassword(String account, String password);
}
