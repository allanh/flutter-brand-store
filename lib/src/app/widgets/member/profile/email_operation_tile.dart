import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/app/widgets/member/profile/common.dart';

/// 建立Email驗證、變更區塊
class EmailOperationTile extends StatelessWidget {
  const EmailOperationTile({
    Key? key,
    required this.context,
    required this.email,
    required this.isValidation,
    required this.handleSendValidationMail,
    required this.handleChangeEmail,
  }) : super(key: key);

  final BuildContext context;
  final String email;
  final bool isValidation;
  final void Function(String? p1) handleSendValidationMail;
  final void Function(String? p2) handleChangeEmail;

  @override
  Widget build(BuildContext context) {
    HyperLinkButton _emailHyperLinkButton = HyperLinkButton(
      context: context,
      text: 'Email變更',
      enable: true,
      handleTap: handleChangeEmail,
    );
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 80.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RequiresText(context: context, text: 'Email'),
              const SizedBox(height: 8.0),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Text(
                        email,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(width: 10.0),
                      Image(
                          image: AssetImage(isValidation
                              ? 'assets/images/icon_completed.png'
                              : 'assets/images/icon_warning_red_circle.png')),
                      ValidResultText(isValid: isValidation)
                    ]),
                    Row(
                        children: isValidation
                            ? [
                                _emailHyperLinkButton,
                              ]
                            : [
                                HyperLinkButton(
                                  context: context,
                                  text: '發送驗證信',
                                  enable: true,
                                  handleTap: handleSendValidationMail,
                                ),
                                const SizedBox(width: 4),
                                _emailHyperLinkButton,
                              ])
                  ])
            ])));
  }
}
