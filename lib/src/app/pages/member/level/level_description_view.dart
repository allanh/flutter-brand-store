import 'package:brandstores/src/domain/entities/member/member_center.dart';
import 'package:flutter/material.dart';

class LevelDescriptionPage extends StatefulWidget {
  const LevelDescriptionPage({Key? key, required this.levelSettings})
      : super(key: key);

  final List<LevelSetting> levelSettings;

  @override
  State<LevelDescriptionPage> createState() => _LevelDescriptionPageState();
}

class _LevelDescriptionPageState extends State<LevelDescriptionPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _currentIndex = 0;

  Color _buildBrownGreyColor() => const Color.fromRGBO(127, 127, 127, 1);
  Color _buildWhiteTwoColor() => const Color.fromRGBO(242, 242, 242, 1);
  Color _buildGreyishBrownColor() => const Color.fromRGBO(76, 76, 76, 1);
  Color _buildBrownGreyTwoColor() => const Color.fromRGBO(180, 180, 180, 1);

  void _handleTabSelection() {
    setState(() {
      _currentIndex = _controller.index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: widget.levelSettings.length, vsync: this);
    _controller.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('等級說明')),
        body: Column(children: [
          Expanded(
              child: DefaultTabController(
                  length: widget.levelSettings.length,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildTabBar(context),
                        _buildTabBarView(context)
                      ])))
        ]));
  }

  Expanded _buildTabBarView(BuildContext context) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TabBarView(
              controller: _controller,
              children: _buildTabBarViewList(context),
            )));
  }

  List<Widget> _buildTabBarViewList(BuildContext context) {
    return List.generate(
      widget.levelSettings.length,
      (index) =>
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildTableHeader(context, index),
        _buildLevelLimitRow(context, index),
        _buildConditionRow(context, index, '等級條件',
            widget.levelSettings[index].levelConditionSpans),
        _buildConditionRow(context, index, '續等條件',
            widget.levelSettings[index].levelKeepConditionSpans),
        Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text('會員等級規則：',
                style: TextStyle(
                  color: _buildGreyishBrownColor(),
                  fontSize: 14.0,
                ))),
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('''
1. 消費紀錄與會員升等將會在訂單完成鑑賞期後的隔日凌晨進行更新。
2. 會員升等一次只會升一個等級，不能跨等級升等。
3. 若您未在會員等級期限內完成該等級的續級條件，將會在到期日的隔日凌晨自動降一個等級。''',
                style:
                    TextStyle(color: _buildBrownGreyColor(), fontSize: 12.0)))
      ]),
    );
  }

  Row _buildConditionRow(
      BuildContext context, int index, String title, List<String> spans) {
    const height = 60.0;
    return Row(
      children: [
        /// Left side
        Container(
          width: 80.0,
          height: height,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: _buildGreyishBrownColor(),
            ),
          ),
          decoration: BoxDecoration(
              color: _buildWhiteTwoColor(),
              border: Border(
                left: _buildBorderSide(),
              )),
          alignment: Alignment.center,
        ),

        /// Right side
        Container(
          width: MediaQuery.of(context).size.width - 80.0 - 24.0,
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: spans.length == 1
                ? Text(spans[0],
                    style: TextStyle(color: _buildGreyishBrownColor()))
                : RichText(
                    text: TextSpan(
                        text: spans[0],
                        style: TextStyle(color: _buildGreyishBrownColor()),
                        children: <TextSpan>[
                          TextSpan(
                              text: spans[1],
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700)),
                          TextSpan(
                            text: spans[2],
                            style: TextStyle(color: _buildGreyishBrownColor()),
                          )
                        ]),
                  ),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: _buildBorderSide(),
                bottom: _buildBorderSide(),
              )),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Row _buildLevelLimitRow(BuildContext context, int index) {
    const height = 36.0;
    return Row(
      children: [
        /// Left side
        Container(
          width: 80.0,
          height: height,
          child: Text(
            '等級期限',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: _buildGreyishBrownColor(),
            ),
          ),
          decoration: BoxDecoration(
              color: _buildWhiteTwoColor(),
              border: Border(
                left: _buildBorderSide(),
              )),
          alignment: Alignment.center,
        ),

        /// Right side
        Container(
          width: MediaQuery.of(context).size.width - 80.0 - 24.0,
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(widget.levelSettings[index].levelPeriodDescription),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: _buildBorderSide(),
                bottom: _buildBorderSide(),
              )),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Container _buildTableHeader(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
          color: _buildWhiteTwoColor(),
          border: Border(
              top: _buildBorderSide(),
              left: _buildBorderSide(),
              right: _buildBorderSide())),
      alignment: Alignment.center,
      height: 36.0,
      width: MediaQuery.of(context).size.width - 24.0,
      child: Text(
        widget.levelSettings[index].name,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
          color: _buildGreyishBrownColor(),
        ),
      ),
    );
  }

  BorderSide _buildBorderSide() {
    return const BorderSide(
        color: Color.fromRGBO(220, 220, 220, 1), width: 1.0);
  }

  Container _buildTabBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6.0, 16.0, 6.0, 17.0),
      child: TabBar(
        controller: _controller,
        labelPadding: const EdgeInsets.only(left: 6.0, right: 6.0),
        isScrollable: true,
        indicator:
            BoxDecoration(color: Theme.of(context).appBarTheme.backgroundColor),
        labelColor: Colors.white,
        unselectedLabelColor: _buildBrownGreyColor(),
        tabs: _buildTabBarList(),
      ),
    );
  }

  List<Widget> _buildTabBarList() {
    return List.generate(
      widget.levelSettings.length,
      (index) => Container(
        width: 120.0,
        height: 40.0,
        decoration: index != _currentIndex
            ? BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(color: _buildBrownGreyTwoColor(), width: 2),
                ),
              )
            : null,
        child: Tab(text: widget.levelSettings[index].name),
      ),
    );
  }
}
