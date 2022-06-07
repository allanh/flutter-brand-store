import 'package:brandstores/src/data/repositories/data_helper_center_repository.dart';
import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_html/flutter_html.dart';

import 'faq_controller.dart';

class FaqPage extends View {
  FaqPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends ViewState<FaqPage, FaqController> {
  _PageState() : super(FaqController(DataHelperCenterRepository()));

  @override
  Widget get view => Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '常見問題')),
      body: ControlledWidgetBuilder<FaqController>(
          builder: (context, controller) {
        return Column(children: [
          Expanded(
              child: DefaultTabController(
                  length: controller.getItems().length,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _tabBar(controller),
                        _tabView(controller)
                      ]))),
          const Text('找不到答案嗎？立即回報給我們。'),
          const SizedBox(height: 8),
          OutlinedButton(
              child: const Text('意見回饋'),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const xxxPage()));
              }),
          const SizedBox(height: 12)
        ]);
      }));

  Container _tabBar(FaqController controller) => Container(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: TabBar(
          isScrollable: true,
          indicator: BoxDecoration(color: ThemeData.light().primaryColor),
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xff7f7f7f),
          tabs: controller
              .getItems()
              .map((item) => Tab(text: item.categoryTitle))
              .toList()));

  Widget _tabView(FaqController controller) => Expanded(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
          child: TabBarView(
              children: controller.getItems().map((category) {
            return category.items.isEmpty
                ? _buildEmptyView(category.categoryTitle)
                : _buildListView(controller, category.items);
          }).toList())));

  Column _buildEmptyView(String title) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_announcement.png'),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('目前尚未有$title'))
        ],
      );

  Widget _buildListView(FaqController controller, List<Article> items) =>
      SingleChildScrollView(
          child: ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (index, isExpand) =>
                  controller.setExpandIndex(index, isExpand),
              children: items.asMap().entries.map((entry) {
                int index = entry.key;
                var item = entry.value;
                return ExpansionPanel(
                    canTapOnHeader: true,
                    isExpanded: controller.expandIndex == index,
                    headerBuilder: (context, isExpanded) =>
                        _buildListTitle(item),
                    body: _buildListContent(item));
              }).toList()));

  Widget _buildListContent(Article item) => SingleChildScrollView(
      child: Container(
          child: Html(data: item.body),
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xffe5e5e5))))));

  Widget _buildListTitle(Article article) => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: const Icon(Icons.add),
        minLeadingWidth: 20,
        title: Text(article.title ?? ''),
        horizontalTitleGap: 10,
      );
}
