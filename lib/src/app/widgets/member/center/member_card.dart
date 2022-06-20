import 'package:flutter/material.dart';
import 'package:brandstores/src/domain/entities/member/member_center.dart';

class MemberCard extends StatelessWidget {
  const MemberCard(
      {Key? key,
      this.member,
      required this.loginButtonTapped,
      required this.avatarTapped})
      : super(key: key);

  final Member? member;

  final Function loginButtonTapped;
  final Function avatarTapped;

  void handleTapped() {
    loginButtonTapped();
  }

  void handleAvatarTapped() {
    if (member != null) {
      avatarTapped();
    }
  }

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
            SizedBox(
              width: 54,
              height: 54,
              child: GestureDetector(
                  onTap: handleAvatarTapped,
                  child: const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/icon_user.png'))),
            ),
            const SizedBox(width: 12.0),
            member == null
                ? TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                    ),
                    onPressed: handleTapped,
                    child: Text('登入/註冊',
                        style: Theme.of(context).textTheme.bodyText2),
                  )
                : Text(name, style: Theme.of(context).textTheme.bodyText2)
          ]),
          color: Colors.white,
          elevation: 5,
          margin: const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ));
  }
}
