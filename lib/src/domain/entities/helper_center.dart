import 'package:brandstores/src/extension/map_extension.dart';
import 'package:brandstores/src/extension/object_extension.dart';

enum ArticleType { terms, privacy, about }

class Faq {
  Faq({
    required this.faqId,
    required this.title,
    required this.groups,
  });

  int faqId;
  String title;
  List<Category> groups;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        faqId: json["faq_id"],
        title: json["title"],
        groups: List<Category>.from(
            json["groups"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson({bool isRemoveNull = false}) => {
        "faq_id": faqId,
        "title": title,
        "groups": List<dynamic>.from(
            groups.map((x) => x.toJson(isRemoveNull: isRemoveNull))),
      }.let((it) => isRemoveNull ? it.removeNull() : it);

  @override
  String toString() => '${toJson(isRemoveNull: true)}';
}

class Category {
  Category({
    required this.categoryId,
    required this.categoryTitle,
    required this.items,
  });

  int categoryId;
  String categoryTitle;
  List<Article> items;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryTitle: json["category_title"],
        items:
            List<Article>.from(json["items"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson({bool isRemoveNull = false}) => {
        "category_id": categoryId,
        "category_title": categoryTitle,
        "items": List<dynamic>.from(
            items.map((x) => x.toJson(isRemoveNull: isRemoveNull))),
      }.let((it) => isRemoveNull ? it.removeNull() : it);

  @override
  String toString() => '${toJson(isRemoveNull: true)}';
}

class Article {
  Article({
    this.categoryId,
    this.categoryTitle,
    this.mainId,
    this.title,
    this.body,
    this.articleDate,
  });

  int? categoryId;
  String? categoryTitle;
  int? mainId;
  String? title;
  String? body;
  String? articleDate;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
      categoryId: json["category_id"],
      categoryTitle: json["category_title"],
      mainId: json["main_id"],
      title: json["title"],
      body: json["body"],
      articleDate: json["article_date"]);

  Map<String, dynamic> toJson({bool isRemoveNull = false}) => {
        "category_id": categoryId,
        "category_title": categoryTitle,
        "main_id": mainId,
        "title": title,
        "body": body,
        "article_date": articleDate,
      }.let((it) => isRemoveNull ? it.removeNull() : it);

  @override
  String toString() => '${toJson(isRemoveNull: true)}';
}
