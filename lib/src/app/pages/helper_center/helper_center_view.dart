import 'package:brandstores/src/app/pages/helper_center/bulletin/bulletin_view.dart';
import 'package:brandstores/src/app/pages/helper_center/faq/faq_view.dart';
import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:flutter/material.dart';

import 'article/article_view.dart';

class HelperCenterPage extends StatelessWidget {
  const HelperCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const pageTitle = '幫助中心';
    final items = <String>['常見問題', '服務公告', '隱私權條款', '會員條款', '關於我們'];
    return Scaffold(
      appBar: AppBar(title: const Text(pageTitle)),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xffe5e5e5)))),
            child: _buildItem(
              items[index],
              () => _openPage(context, index, items[index]),
            ),
          );
        },
      ),
    );
  }

  _openPage(BuildContext context, int position, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      switch (position) {
        case 0:
          return FaqPage(title: title);
        case 1:
          return BulletinPage(title: title);
        case 2:
          return ArticlePage(ArticleType.privacy, title: title);
        case 3:
          return ArticlePage(ArticleType.terms, title: title);
        case 4:
        default:
          return ArticlePage(ArticleType.about, title: title);
      }
    }));
  }

  Widget _buildItem(String name, GestureTapCallback onclick) {
    return ListTile(
        textColor: const Color(0xff4c4c4c),
        title: Text(name),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          color: Color(0xff7f7f7f),
        ),
        onTap: onclick);
  }
}
