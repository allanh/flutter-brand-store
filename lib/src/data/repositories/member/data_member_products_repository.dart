import 'package:brandstores/src/data/utils/dio/dio_utils.dart';
import 'package:brandstores/src/data/utils/dio/api.dart';
import 'package:brandstores/src/domain/entities/member/member_products.dart';
import 'package:brandstores/src/domain/repositories/member/member_products_repository.dart';

class DataMemberProductsRepository extends MemberProductsRepository {
  static final DataMemberProductsRepository _instance =
      DataMemberProductsRepository._internal();
  DataMemberProductsRepository._internal();
  factory DataMemberProductsRepository() => _instance;

  @override
  Future<MemberProductsInfo> getMemberBrowseProducts(int page) async {
    try {
      final response =
          await HttpUtils.instance.post(Api.historyProducts, params: {
        'current_page': page,
      });
      if (response.isSuccess) {
        return MemberProductsInfo.fromJson(response.data);
      }
      throw Exception('Failed to get member history products.');
    } catch (e) {
      throw Exception('Failed to get member history products.');
    }
  }

  @override
  Future<MemberProductsInfo> getMemberFavoriteProducts(int page) async {
    try {
      final response =
          await HttpUtils.instance.post(Api.favoriteProducts, params: {
        "filter": "new_goods",
        "current_page": page,
      });
      if (response.isSuccess) {
        return MemberProductsInfo.fromJson(response.data);
      }
      throw Exception('Failed to get member favorite products.');
    } catch (e) {
      throw Exception('Failed to get member favorite products.');
    }
  }

  @override
  Future<MemberProductsInfo> getMemberBoughtProducts(int page) async {
    try {
      final response =
          await HttpUtils.instance.post(Api.bougthProducts, params: {
        "current_page": page.toString(),
        "limit": "10",
      });
      if (response.isSuccess) {
        return MemberProductsInfo.fromJson(response.data);
      }
      throw Exception('Failed to get member bought products.');
    } catch (e) {
      throw Exception('Failed to get member bought products.');
    }
  }
}
