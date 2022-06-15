/// The 'Domain' module defines the business logic of the application.
/// It is a module that is independent from the development platform
/// i.e. it is written purely in the programming language and does
/// not contain any elements from the platform. In the case of 'Flutter',
/// 'Domain' would be written purely in 'Dart' without any 'Flutter'
/// elements. The reason for that is that 'Domain' should only be concerrned
/// with the business logic of the application, not with the implementation
/// details. This also allows for easy migration between platform, should
/// any issues arise.
import 'package:brandstores/src/data/utils/dio/base_res.dart';
import 'package:brandstores/src/domain/entities/member/member_profile.dart';

/// Repositories
/// - Abstract classes that define the expected functionality of outer layers
/// - Are not aware of outer layers, simply define expected functionality
///   * E.g. The 'Login' usecase exprects a 'Repository' that has 'login'
///     functionality
/// - Passed to 'Usecases' from outer layers
abstract class MemberProfileRepository {
  /// 取會員資料
  Future<MemberProfile> getMemberProfile();

  /// 手機驗證
  Future<VerificationResult> verifyMobile(String countryCode, String mobile);

  /// 取得郵遞區號
  Future<List<Districts>> loadDistricts();

  /// 會員資料更新
  Future<BaseResponse> updateProfile(MemberProfile? profile);
}
