import 'package:brandstores/src/data/utils/dio/dio_utils.dart';
import 'package:brandstores/src/data/utils/dio/api.dart';
import 'package:brandstores/src/domain/entities/member_center/member_products/member_products.dart';
import 'package:brandstores/src/domain/repositories/member_products_repository.dart';

class DataMemberProductsRepository extends MemberProductsRepository {
  static final DataMemberProductsRepository _instance =
      DataMemberProductsRepository._internal();
  DataMemberProductsRepository._internal();
  factory DataMemberProductsRepository() => _instance;

  @override
  Future<MemberProducts> getMemberHistoryProducts() async {
    try {
      final response =
          await HttpUtils.instance.post(Api.historyProducts, params: {
        'current_page': 1,
      });
      if (response.isSuccess) {
        return MemberProducts.fromJson(response.data);
      }
      throw Exception('Failed to get member history products.');
    } catch (e) {
      throw Exception('Failed to get member history products.');
    }
  }

  @override
  Future<MemberProducts> getMemberFavoriteProducts() async {
    try {
      final response =
          await HttpUtils.instance.post(Api.favoriteProducts, params: {
        "filter": "new_goods",
        "current_page": 1,
      });
      if (response.isSuccess) {
        return MemberProducts.fromJson(response.data);
      }
      throw Exception('Failed to get member favorite products.');
    } catch (e) {
      throw Exception('Failed to get member favorite products.');
    }
  }

  @override
  Future<MemberProducts> getMemberBoughtProducts() async {
    try {
      final response =
          await HttpUtils.instance.post(Api.bougthProducts, params: {
        "current_page": "1",
        "limit": "10",
      });
      if (response.isSuccess) {
        return MemberProducts.fromJson(response.data);
      }
      throw Exception('Failed to get member bought products.');
    } catch (e) {
      throw Exception('Failed to get member bought products.');
    }
  }
}
