import '../../domain/entities/product/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../data/utils/dio/api.dart';
import '../../data/utils/dio/dio_utils.dart';

class DataProductRepository extends ProductRepository {
  Product? product;

  /// Singleton object of `DataAuthenticationRepository`
  static final DataProductRepository _instance =
      DataProductRepository._internal();

  // Constructors
  DataProductRepository._internal();

  factory DataProductRepository() => _instance;

  @override
  Future<Product> getProduct({required String goodsNo, int? productId}) async {
    // Here, do some heavy work lke http requests, async tasks, etc to get data

    final response = await HttpUtils.instance.post(Api.getProduct,
        params: {'goods_no': goodsNo, 'product_id': productId});
    if (response.isSuccess) {
      // Map<String, dynamic> ProductResponseMap = response.data;
      // Product.current = Product.fromJson(response.data);
      return Product.fromJson(response.data);
    } else {
      throw Exception('Failed to load site setting');
    }
  }
}
