import 'package:brandstores/src/app/pages/member_center/profile/member_profile_controller.dart';
import 'package:brandstores/src/data/repositories/data_member_profile_repository.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MemberProfilePage extends View {
  MemberProfilePage({Key? key}) : super(key: key);

  @override
  State<MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState
    extends ViewState<MemberProfilePage, MemberProfileController> {
  _MemberProfilePageState()
      : super(MemberProfileController(DataMemberProfileRepository()));

  @override
  Widget get view {
    return Scaffold(
      appBar: AppBar(title: const Text('會員資料')),
      body: ControlledWidgetBuilder<MemberProfileController>(
        builder: (context, controller) {
          return Container(
            child: Column(
              children: [
                /// 生日修改次數說明
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48.0,
                    child: Text('作為系統預設之訂購人資料，請務必填寫正確(生日僅可修改一次)。',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(color: UdiColors.brownGrey)),
                  ),
                ),

                /// 姓名區塊
                Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 80.0,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: '姓名',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(color: UdiColors.greyishBrown),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "*",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                                color: UdiColors.strawberry))
                                  ]),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter a search term',
                                ),
                              ),
                            ),
                          ]),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
