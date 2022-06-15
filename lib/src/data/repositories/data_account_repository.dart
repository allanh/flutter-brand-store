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
    final response = await HttpUtils.instance.post(Api.login,
        params: {"mobile_code": mobileCode, "mobile": mobile, "email": email, "pwd": password});
    if (response.isSuccess) {
      _saveToken(response.data["access_token"] as String?);
    }
    return response;
  }

  _saveToken(String? token) {
    if (token != null && token.length > 1) {
      _storage.write(MyKey.auth, token);
    }
  }

  @override
  Future<BaseResponse> sendVerification(
      VerifyType verifyType, String mobileCode, String mobile, String email) async {
    final response = await HttpUtils.instance.post(Api.sendVerification, params: {
      "mobile_code": mobileCode,
      "mobile": mobile,
      "email": email,
      "verify_type": verifyType.value
    });
    if (response.isSuccess && verifyType == VerifyType.addMember) {
      _saveToken(response.data["access_token"] as String?);
    }
    return response;
  }

  @override
  Future<BaseResponse> verifyMobileCode(
      VerifyType verifyType, String mobileCode, String mobile, String verifyCode) async {
    final response = await HttpUtils.instance.post(Api.verifyMobileCode, params: {
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
    final response = await HttpUtils.instance.post(Api.resetPassword,
        params: {"mobile_code": mobileCode, "mobile": mobile, "email": email, "pwd": password});
    return response;
  }

  @override
  Future<bool> accountIsExist(String mobileCode, String mobile, String email) async {
    final response = await HttpUtils.instance.post(Api.accountCheck,
        params: {"mobile_code": mobileCode, "mobile": mobile, "email": email});
    return response.isSuccess && response.data["exist"] == true;
  }

  @override
  Future<BaseResponse> registerMobile({
    required String name,
    required String mobileCode,
    required String mobile,
    required String pwd,
    String? gender,
    DateTime? birth,
    String? zip,
    String? cityNo,
    String? areaNo,
    String? address,
  }) async {
    return _register(
        name: name,
        mobileCode: mobileCode,
        mobile: mobile,
        email: null,
        pwd: pwd,
        gender: gender,
        birth: birth,
        zip: zip,
        cityNo: cityNo,
        areaNo: areaNo,
        address: address);
  }

  @override
  Future<BaseResponse> registerEmail({
    required String name,
    required String email,
    required String pwd,
    String? gender,
    DateTime? birth,
    String? zip,
    String? cityNo,
    String? areaNo,
    String? address,
  }) async {
    return _register(
        name: name,
        mobileCode: null,
        mobile: null,
        email: email,
        pwd: pwd,
        gender: gender,
        birth: birth,
        zip: zip,
        cityNo: cityNo,
        areaNo: areaNo,
        address: address);
  }

  Future<BaseResponse> _register({
    required String name,
    required String? mobileCode,
    required String? mobile,
    required String? email,
    required String pwd,
    required String? gender,
    required DateTime? birth,
    required String? zip,
    required String? cityNo,
    required String? areaNo,
    required String? address,
  }) async {
    final response = await HttpUtils.instance.post(Api.register, params: {
      "name": name,
      "mobile_code": mobileCode,
      "mobile": mobile,
      "email": email,
      "pwd": pwd,
      "gender": gender,
      "birth": birth == null
          ? null
          : "${birth.year.toString().padLeft(4, '0')}-${birth.month.toString().padLeft(2, '0')}-${birth.day.toString().padLeft(2, '0')}",
      "zip": zip,
      "cityno": cityNo,
      "areano": areaNo,
      "address": address,
    });
    return response;
  }
}
