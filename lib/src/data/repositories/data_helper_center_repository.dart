import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:brandstores/src/domain/repositories/helper_center_repository.dart';

import '../../data/utils/dio/api.dart';
import '../../data/utils/dio/dio_utils.dart';


class DataHelperCenterRepository extends HelperCenterRepository {
  @override
  Future<Faq> getFaq() async {
    final response = await HttpUtils.instance.get(Api.faq);
    if (response.isSuccess) {
      return Faq.fromJson(response.data);
    } else {
      throw Exception('Failed to load bulletin');
    }
  }

  @override
  Future<List<Category>> getBulletin() async {
    final response = await HttpUtils.instance.get(Api.bulletin);
    if (response.isSuccess) {
      return (response.data as List).map((item) => item as Category).toList();
    } else {
      throw Exception('Failed to load bulletin');
    }
  }

  @override
  Future<Article> getBulletinContent(int mainId) async {
    final response = await HttpUtils.instance.get('${Api.bulletin}/$mainId');
    if (response.isSuccess) {
      return Article.fromJson(response.data);
    } else {
      throw Exception('Failed to load bulletin $mainId');
    }
  }

  @override
  Future<Article> getArticle(ArticleType articleType) async {
    String api;
    switch (articleType) {
      case ArticleType.terms:
        api = Api.terms;
        break;
      case ArticleType.privacy:
        api = Api.privacy;
        break;
      case ArticleType.about:
        api = Api.about;
        break;
    }

    final response = await HttpUtils.instance.get(api);
    if (response.isSuccess) {
      return Article.fromJson(response.data);
    } else {
      throw Exception('Failed to load ${articleType.name}');
    }
  }
}
