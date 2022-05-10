import 'package:flutter/material.dart';
import 'package:brandstores/src/domain/entities/member_center/member_center.dart';

class MemberLevelCard extends StatelessWidget {
  const MemberLevelCard({Key? key, required this.member}) : super(key: key);

  final Member member;

  @override
  Widget build(BuildContext context) {
    var name = member.name ?? member.mobile ?? '';

    return SizedBox(
        height: 159.0,
        child: Card(
          child: Column(
            children: [
              Row(children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: SizedBox(
                      width: 54,
                      height: 54,
                      child: CircleAvatar(
                          backgroundImage: AssetImage('assets/icon_user.png'))),
                ),
                Padding(
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
                            color: Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                      Text(
                        member.period,
                        style: const TextStyle(
                            fontFamily: 'PingFangTC-Semibold',
                            fontSize: 12.0,
                            color: Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                    ],
                  ),
                )
              ]),
              Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Column(
                    children: [
                      Row(
                        children: List.generate(
                            member.levelSettings.length,
                            (index) => SizedBox(
                                height: 6.0,
                                child: Row(children: [
                                  /// 利用現在的會員等級跟清單中的等級比較
                                  /// 如果現在的會員等級大於清單中的等級
                                  /// 則顯示主題色，反之，顯示灰色
                                  Container(
                                      color: member.level >=
                                              member.levelSettings[index].level
                                          ? Colors.orange
                                          : Colors.black26,
                                      width: (MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              92.0 -
                                              ((member.levelSettings.length -
                                                      1) *
                                                  8)) /
                                          member.levelSettings.length),

                                  /// 等級條間距
                                  Container(
                                      color: Colors.transparent,

                                      /// 最後一個等級不需要間距
                                      width: (index ==
                                              member.levelSettings.length - 1)
                                          ? 0.0
                                          : 8.0)
                                ]))),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: <Widget>[
                          const Expanded(
                              child: Text('Lv.1',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'PingFangTC-Regular',
                                      fontSize: 12.0,
                                      color:
                                          Color.fromRGBO(180, 180, 180, 1)))),
                          Expanded(
                              child: Text(
                                  'Lv.${member.levelSettings.last.level}',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      fontFamily: 'PingFangTC-Regular',
                                      fontSize: 12.0,
                                      color: Color.fromRGBO(180, 180, 180, 1))))
                        ],
                      )
                    ],
                  ))
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
