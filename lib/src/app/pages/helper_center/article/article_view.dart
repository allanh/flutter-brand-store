import 'package:brandstores/src/data/repositories/data_helper_center_repository.dart';
import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_html/flutter_html.dart';

import 'article_controller.dart';

class ArticlePage extends View {
  ArticlePage(this.articleType, {Key? key, this.title}) : super(key: key);

  final String? title;

  final ArticleType articleType;

  @override
  // ignore: no_logic_in_create_state
  _PageState createState() => _PageState(articleType);
}

class _PageState extends ViewState<ArticlePage, ArticleController> {
  _PageState(articleType)
      : super(ArticleController(DataHelperCenterRepository(), articleType));

  @override
  Widget get view {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: SingleChildScrollView(
        child: ControlledWidgetBuilder<ArticleController>(
          builder: (context, controller) {
            return Html(data: controller.article?.body ?? '');
          },
        ),
      ),
    );
  }
}
