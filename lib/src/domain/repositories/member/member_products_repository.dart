import 'package:brandstores/src/domain/entities/member/member_products.dart';

abstract class MemberProductsRepository {
  Future<MemberProductsInfo> getMemberBrowseProducts(int page);

  Future<MemberProductsInfo> getMemberFavoriteProducts(int page);

  Future<MemberProductsInfo> getMemberBoughtProducts(int page);
}
