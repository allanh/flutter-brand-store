import 'package:brandstores/src/data/repositories/data_helper_center_repository.dart';
import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_html/flutter_html.dart';

import 'bulletin_controller.dart';

class BulletinPage extends View {
  BulletinPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends ViewState<BulletinPage, BulletinController> {
  _PageState() : super(BulletinController(DataHelperCenterRepository()));

  @override
  Widget get view => Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: ControlledWidgetBuilder<BulletinController>(
          builder: ((context, controller) {
        return Column(children: [
          Expanded(
              child: DefaultTabController(
                  length: controller.getItems().length,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _tabBar(controller),
                        _tabView(controller)
                      ])))
        ]);
      })));

  Container _tabBar(BulletinController controller) => Container(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: TabBar(
        isScrollable: true,
        indicator: BoxDecoration(color: ThemeData.light().primaryColor),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xff7f7f7f),
        tabs: controller.getTabs().map((item) => Tab(text: item)).toList(),
      ));

  Expanded _tabView(BulletinController controller) => Expanded(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
          child: TabBarView(
              children: controller.getItems().map((category) {
            return category.items.isEmpty
                ? _buildEmptyView(category.categoryTitle)
                : _buildListView(category.items);
          }).toList())));

  Column _buildEmptyView(String title) =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/empty_announcement.png'),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text('目前尚未有$title'),
        )
      ]);

  ListView _buildListView(List<Article> items) => ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => _buildListItem(items[index]));

  Column _buildListItem(Article article) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.all(12),
            child: Text(article.title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ))),
        Html(
            data: article.body?.replaceAll('\\n', ''),
            tagsList: Html.tags..remove("img"),
            style: {
              'body': Style(
                  padding: EdgeInsets.zero,
                  maxLines: 2,
                  textOverflow: TextOverflow.clip,
                  margin: const EdgeInsets.symmetric(horizontal: 12))
            }),
        Row(children: [
          const SizedBox(width: 12),
          const Icon(Icons.access_time_filled, size: 14),
          const SizedBox(width: 4),
          Expanded(
              child: Text(article.articleDate ?? '',
                  style: const TextStyle(fontSize: 12))),
          OutlinedButton(
              child: const Text('看更多', style: TextStyle(fontSize: 14)),
              onPressed: () => _clickSeeMore(article),
              style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 0),
                  padding: const EdgeInsets.fromLTRB(14, 2, 14, 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ))),
          const SizedBox(width: 12)
        ]),
        const Divider(height: 1)
      ]);

  void _clickSeeMore(Article article) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (context) => Scaffold(
            appBar: AppBar(title: Text(article.title ?? '')),
            body: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(article.title ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 12),
                      Row(children: [
                        const Icon(Icons.access_time_filled, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          article.articleDate ?? '',
                          style: const TextStyle(fontSize: 12),
                        )
                      ]),
                      Html(data: article.body),
                    ])))));
  }
}
