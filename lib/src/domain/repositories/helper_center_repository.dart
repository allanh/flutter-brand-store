import '../entities/helper_center.dart';

abstract class HelperCenterRepository {
  Future<Faq> getFaq();

  Future<List<Category>> getBulletin();

  Future<Article> getBulletinContent(int mainId);

  Future<Article> getArticle(ArticleType articleType);
}
