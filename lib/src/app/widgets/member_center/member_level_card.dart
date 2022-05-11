import 'package:flutter/material.dart';
import 'package:brandstores/src/domain/entities/member_center/member_center.dart';

class MemberLevelCard extends StatelessWidget {
  const MemberLevelCard(
      {Key? key,
      required this.member,
      required this.levelDescriptionButtonTapped})
      : super(key: key);

  final Member member;

  final Function levelDescriptionButtonTapped;

  void _handleTap() {
    levelDescriptionButtonTapped();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 159.0,
        child: Card(
          child: Stack(
            children: [
              /// 背景圖片
              BackgroundImage(member: member),

              /// 會員資訊
              MemberInformation(member: member),

              /// 等級說明按鈕
              LevelDescriptionButton(buttonTapped: _handleTap),
            ],
          ),
          color: Colors.white,
          elevation: 5,
          margin: const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ));
  }
}

class MemberInformation extends StatelessWidget {
  const MemberInformation({
    Key? key,
    required this.member,
  }) : super(key: key);

  final Member member;

  @override
  Widget build(BuildContext context) {
    var name = member.name ?? member.mobile ?? '';
    return Column(
      children: [
        Row(children: [
          /// 大頭照
          const Avatar(),

          /// 姓名/等級/有效期限
          Information(name: name, member: member),
        ]),

        /// 等級條區塊
        LevelBar(member: member)
      ],
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.member,
  }) : super(key: key);

  final Member member;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: member.backgroundSmallImgUrl != null
          ? Image(image: NetworkImage(member.backgroundSmallImgUrl!))
          : const Image(image: AssetImage('assets/mask.png')),
    );
  }
}

class LevelDescriptionButton extends StatelessWidget {
  const LevelDescriptionButton({Key? key, required this.buttonTapped})
      : super(key: key);

  final Function buttonTapped;

  void _handleTap() {
    buttonTapped();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0, right: 12.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 8,
                primary: Colors.white,
                shape: const StadiumBorder()),
            onPressed: _handleTap,
            child: const Text('等級說明',
                softWrap: false,
                style: TextStyle(
                    fontFamily: 'PingFangTC-Regular',
                    fontSize: 12.0,
                    color: Color.fromRGBO(76, 76, 76, 1))),
          ),
        ),
      ],
    );
  }
}

class LevelBar extends StatelessWidget {
  const LevelBar({
    Key? key,
    required this.member,
  }) : super(key: key);

  final Member member;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontFamily: 'PingFangTC-Regular',
        fontSize: 12.0,
        color: Color.fromRGBO(180, 180, 180, 1));
    return Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          children: [
            /// 等級條
            Row(
              children: _buildBarList(),
            ),
            const SizedBox(height: 4.0),

            /// 最小等級/最大等級
            Row(
              children: <Widget>[
                const Expanded(
                    child: Text('Lv.1',
                        textAlign: TextAlign.left, style: textStyle)),
                Expanded(
                    child: Text('Lv.${member.levelSettings.last.level}',
                        textAlign: TextAlign.right, style: textStyle))
              ],
            )
          ],
        ));
  }

  List<Widget> _buildBarList() {
    return List.generate(member.levelSettings.length,
        (index) => Bar(member: member, index: index));
  }
}

class Bar extends StatelessWidget {
  const Bar({
    Key? key,
    required this.member,
    required this.index,
  }) : super(key: key);

  final Member member;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
        height: 6.0,
        child: Row(children: [
          /// 利用現在的會員等級跟清單中的等級比較
          /// 如果現在的會員等級大於清單中的等級
          /// 則顯示主題色，反之，顯示灰色
          Container(
              color: member.level >= member.levelSettings[index].level
                  ? theme.appBarTheme.backgroundColor
                  : Colors.black26,
              width: (MediaQuery.of(context).size.width -
                      92.0 -
                      ((member.levelSettings.length - 1) * 8)) /
                  member.levelSettings.length),

          /// 等級條間距
          Container(
              color: Colors.transparent,

              /// 最後一個等級不需要間距
              width: (index == member.levelSettings.length - 1) ? 0.0 : 8.0)
        ]));
  }
}

class Information extends StatelessWidget {
  const Information({
    Key? key,
    required this.name,
    required this.member,
  }) : super(key: key);

  final String name;
  final Member member;

  @override
  Widget build(BuildContext context) {
    const color2 = Color.fromRGBO(0, 0, 0, 0.5);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 34.0, 24.0, 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
                fontFamily: 'PingFangTC-Semibold',
                fontSize: 16.0,
                color: Color.fromRGBO(76, 76, 76, 1.0)),
          ),
          Text(
            member.levelName,
            style: const TextStyle(
                fontFamily: 'PingFangTC-Semibold',
                fontSize: 16.0,
                color: color2),
          ),
          Text(
            member.period,
            style: const TextStyle(
                fontFamily: 'PingFangTC-Semibold',
                fontSize: 12.0,
                color: color2),
          ),
        ],
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Container(
        width: 54,
        height: 54,
        foregroundDecoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage('assets/icon_user.png'),
                colorFilter: ColorFilter.mode(
                    theme.appBarTheme.backgroundColor!, BlendMode.srcIn))),
      ),
    );
  }
}
