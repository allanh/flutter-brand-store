import 'package:brandstores/src/domain/entities/member_center/member_products/member_products.dart';

abstract class MemberProductsRepository {
  Future<MemberProducts> getMemberHistoryProducts();

  Future<MemberProducts> getMemberFavoriteProducts();

  Future<MemberProducts> getMemberBoughtProducts();
}
