import 'package:brandstores/src/app/pages/member_center/profile/member_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MemberProfilePage extends StatefulWidget {
  const MemberProfilePage({Key? key}) : super(key: key);

  @override
  State<MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends State<MemberProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ControlledWidgetBuilder<MemberProfileController>(
      builder: (context, controller) {
        if (controller.memberProfile != null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('會員資料'),
            ),
          );
        }
        return Container();
      },
    );
  }
}
