import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/app/widgets/member/profile/common.dart';

/// 建立密碼設定區塊
class PasswordSettingTile extends StatelessWidget {
  const PasswordSettingTile({
    Key? key,
    required this.context,
    required this.isSettingPassword,
    required this.handleTap,
  }) : super(key: key);

  final BuildContext context;
  final bool isSettingPassword;
  final void Function(String? p1) handleTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 80.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '密碼',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 14.0),
              ),
              const SizedBox(height: 8.0),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Text(
                        isSettingPassword ? '************' : '-',
                        style: Theme.of(context).textTheme.caption!,
                      ),
                    ]),
                    Row(children: [
                      isSettingPassword
                          ? HyperLinkButton(
                              context: context,
                              text: '修改密碼',
                              enable: true,
                              handleTap: handleTap)
                          : HyperLinkButton(
                              context: context,
                              text: '設定密碼',
                              enable: true,
                              handleTap: handleTap)
                    ])
                  ])
            ])));
  }
}
