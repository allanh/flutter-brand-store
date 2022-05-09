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
  Widget get view {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: ControlledWidgetBuilder<BulletinController>(
        builder: ((context, controller) {
          return Column(
            children: [
              DefaultTabController(
                  length: controller.bulletin?.length ?? 0, // length of tabs
                  // initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: TabBar(
                            isScrollable: true,
                            indicator: BoxDecoration(
                                color: ThemeData.light().primaryColor,
                                // color: Theme.of(context).primaryColor
                              ),
                            labelColor: Colors.white,
                            unselectedLabelColor: const Color(0xff7f7f7f),
                            tabs: controller
                                .getTabs()
                                .map((item) => Tab(text: item))
                                .toList(),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            // constraints: BoxConstraints.expand(),
                            height: 400,
                            //height of TabBarView
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: TabBarView(
                                children: controller.getItems().map((category) {
                              return ListView.builder(
                                  itemCount: category.items.length,
                                  itemBuilder: (context, index) =>
                                      _buildItem(category.items[index]));
                            }).toList()))
                      ])),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            article.title ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Html(
            data: article.body?.replaceAll('\\n', ''),
            tagsList: Html.tags..remove("img"),
            style: {
              'body': Style(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: EdgeInsets.zero,
                maxLines: 2,
                textOverflow: TextOverflow.clip,
              ),
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(Icons.access_time_filled, size: 14),
              Expanded(
                child: Text(
                  article.articleDate ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(14, 2, 14, 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  onPressed: () {},
                  child: const Text('看更多', style: TextStyle(fontSize: 14)))
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
