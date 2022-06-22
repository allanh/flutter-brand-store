import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import '../../../pages/member/profile/member_profile_controller.dart';

class BindingDialog extends StatelessWidget {
  const BindingDialog({
    Key? key,
    required this.name,
    required this.controller,
  }) : super(key: key);

  final String name;

  final MemberProfileController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      contentPadding: const EdgeInsets.fromLTRB(24.0, 66.0, 24.0, 36.0),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      content: Text('確定要解除綁定？',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: UdiColors.greyishBrown)),
      actions: <Widget>[
        SizedBox(
          width: 117.0,
          height: 36.0,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context, '取消'),
            child: const Text('取消'),
            style: OutlinedButton.styleFrom(
                primary: Theme.of(context).appBarTheme.backgroundColor),
          ),
        ),
        SizedBox(
          width: 117.0,
          height: 36.0,
          child: ElevatedButton(
              onPressed: () {
                controller.handleUnbinding(name);
                Navigator.pop(context, '確定');
              },
              child: const Text('確定'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).appBarTheme.backgroundColor,
              )),
        ),
      ],
    );
  }
}
