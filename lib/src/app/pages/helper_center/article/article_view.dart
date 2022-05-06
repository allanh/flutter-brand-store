import 'package:brandstores/src/data/repositories/data_helper_center_repository.dart';
import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'article_controller.dart';

class ArticlePage extends View {
  ArticlePage(this.articleType, {Key? key, this.title}) : super(key: key);

  final String? title;

  final ArticleType articleType;

  @override
  // ignore: no_logic_in_create_state
  _ArticlePageState createState() => _ArticlePageState(articleType);
}

@mustCallSuper
class _ArticlePageState extends ViewState<ArticlePage, ArticleController> {
  _ArticlePageState(articleType)
      : super(ArticleController(DataHelperCenterRepository(), articleType));

  @override
  Widget get view {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: SingleChildScrollView(
        child: ControlledWidgetBuilder<ArticleController>(
          builder: (context, controller) {
            return Text(controller.article?.body ?? '');
          },
        ),
      ),
    );
  }
}
