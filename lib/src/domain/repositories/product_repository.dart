import '../entities/product/product.dart';

abstract class ProductRepository {
  Future<Product> getProduct({required String goodsNo, int? productId});
}
