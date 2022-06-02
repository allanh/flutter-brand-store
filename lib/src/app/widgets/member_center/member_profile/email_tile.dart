import 'package:flutter/material.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/common.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/email_operation_tile.dart';

/// Email 區塊
/// - [email] 電子郵件
/// - [isVerify] 電子郵件是否驗證過
/// - [isValid] 電子郵件格式是否符合規則有效
/// - [handleEmailChange] 電子郵件變更按鈕點擊 callback
/// - [handleSendValidationMail] 發送驗證信按鈕點擊 callback
/// - [handleChangeEmail] 電子郵件編輯 callback
class EmailTile extends StatelessWidget {
  const EmailTile({
    Key? key,
    required this.context,
    required this.email,
    required this.isVerify,
    required this.isValid,
    required this.handleEmailChange,
    required this.handleSendValidationMail,
    required this.handleChangeEmail,
  }) : super(key: key);

  final BuildContext context;
  final String? email;
  final bool isVerify;
  final bool isValid;
  final void Function(String? p1) handleEmailChange;
  final void Function(String? p1) handleSendValidationMail;
  final void Function(String? p2) handleChangeEmail;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      email != null && isVerify == true
          ? EmailOperationTile(
              context: context,
              email: email ?? '',
              isValidation: isVerify,
              handleSendValidationMail: handleSendValidationMail,
              handleChangeEmail: handleChangeEmail,
            )
          : InputTile(
              context: context,
              title: 'Email',
              text: email,
              hintText: '請輸入Email',
              errorText: '請輸入有效Email',
              isValid: isValid,
              handleChange: handleEmailChange,
            )
    ]);
  }
}
