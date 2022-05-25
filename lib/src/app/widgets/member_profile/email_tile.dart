import 'package:flutter/material.dart';
import 'package:brandstores/src/app/widgets/member_profile/common.dart';
import 'package:brandstores/src/app/widgets/member_profile/email_operation_tile.dart';
import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';
import 'package:brandstores/src/app/pages/member_center/profile/member_profile_controller.dart';

class EmailTile extends StatelessWidget {
  const EmailTile({
    Key? key,
    required this.context,
    required this.controller,
    required this.profile,
    required this.handleEmailChange,
  }) : super(key: key);

  final BuildContext context;
  final MemberProfileController controller;
  final MemberProfile? profile;
  final void Function(String? p1) handleEmailChange;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      profile?.email != null && profile?.isVerifyEmail == true
          ? EmailOperationTile(
              context: context,
              controller: controller,
              email: profile?.email ?? '',
              isValidation: profile?.isVerifyEmail ?? false,
              handleTap: (message) {
                debugPrint(message);
              })
          : InputTile(
              context: context,
              title: 'Email',
              text: profile?.email,
              hintText: '請輸入Email',
              errorText: '請輸入有效Email',
              isValid: controller.validateEmail(profile?.email),
              handleChange: handleEmailChange)
    ]);
  }
}
