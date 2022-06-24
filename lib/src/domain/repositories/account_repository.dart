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

  Future<BaseResponse> setPassword(String oldPassword, String password);

  Future<bool> accountIsExist(String mobileCode, String mobile, String email);

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
  });

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
  });
}
