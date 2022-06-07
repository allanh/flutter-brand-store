import 'package:brandstores/src/domain/entities/account/account_body.dart';
import 'package:brandstores/src/domain/entities/enum/verify_type.dart';
import 'package:brandstores/src/domain/repositories/account_repository.dart';

import '../utils/dio/api.dart';
import '../utils/dio/base_res.dart';
import '../utils/dio/dio_utils.dart';
import '../utils/storage/my_key.dart';
import '../utils/storage/secure_storage.dart';

class DataAccountRepository extends AccountRepository {
  final _storage = SecureStorage();

  @override
  Future<BaseResponse> login(
      String mobileCode, String mobile, String email, String password) async {
    final response = await HttpUtils.instance.post(Api.login, params: {
      "mobile_code": mobileCode,
      "mobile": mobile,
      "email": email,
      "pwd": password
    });
    if (response.isSuccess) {
      var token = response.data["access_token"] as String?;
      if (token != null && token.length > 1) {
        _storage.write(MyKey.auth, token);
      }
    }
    return response;
  }

  @override
  Future<BaseResponse> sendVerification(VerifyType verifyType,
      String mobileCode, String mobile, String email) async {
    final response =
        await HttpUtils.instance.post(Api.sendVerification, params: {
      "mobile_code": mobileCode,
      "mobile": mobile,
      "email": email,
      "verify_type": verifyType.value
    });
    return response;
  }

  @override
  Future<BaseResponse> verifyMobileCode(VerifyType verifyType,
      String mobileCode, String mobile, String verifyCode) async {
    final response =
        await HttpUtils.instance.post(Api.verifyMobileCode, params: {
      "mobile_code": mobileCode,
      "mobile": mobile,
      "verify_code": verifyCode,
      "verify_type": verifyType.value
    });
    return response;
  }

  @override
  Future<BaseResponse> resetPassword(
      String mobileCode, String mobile, String email, String password) async {
    final response =
        await HttpUtils.instance.post(Api.resetPassword, params: {
      "mobile_code": mobileCode,
      "mobile": mobile,
      "email": email,
      "pwd": password
    });
    return response;
  }

  @override
  Future<bool> accountIsExist(
      String mobileCode, String mobile, String email) async {
    final response = await HttpUtils.instance.post(Api.accountCheck,
        params: {"mobile_code": mobileCode, "mobile": mobile, "email": email});
    return response.isSuccess && response.data["exist"] == true;
  }

  @override
  Future<BaseResponse> register(AccountBody accountBody) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
