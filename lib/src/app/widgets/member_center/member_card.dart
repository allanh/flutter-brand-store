import 'package:flutter/material.dart';
import 'package:brandstores/src/domain/entities/member_center/member_center.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({Key? key, this.member}) : super(key: key);

  final Member? member;

  @override
  Widget build(BuildContext context) {
    var name = member?.name ?? member?.mobile ?? '';

    return SizedBox(
        height: 110.0,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(children: [
            const Padding(padding: EdgeInsets.only(left: 24.0)),
            const SizedBox(
                width: 54,
                height: 54,
                child: CircleAvatar(
                    backgroundImage: AssetImage('assets/icon_user.png'))),
            const SizedBox(width: 12.0),
            Text(
              member == null ? '登入/註冊' : name,
              style: const TextStyle(
                  fontFamily: 'PingFangTC-Semibold',
                  fontSize: 16.0,
                  color: Color.fromRGBO(76, 76, 76, 1.0)),
            )
          ]),
          color: Colors.white,
          elevation: 5,
          margin: const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ));
  }
}
