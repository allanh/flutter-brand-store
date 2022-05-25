import 'package:flutter/material.dart';
import 'package:brandstores/src/app/widgets/member_profile/common.dart';

/// 建立行動電話輸入框
/// - [context] context
/// - [mobile] 行動電話
/// - [isValidCountryCode] 是否有效的國碼
/// - [isValidMobile] 是否有效的行動電話
/// - [handleCountryCodeChange] 國碼編輯 callback
/// - [handleChange] 行動電話編輯 callback
class MobileInputTile extends StatelessWidget {
  const MobileInputTile({
    Key? key,
    required this.context,
    required this.mobile,
    required this.isValidCountryCode,
    required this.isValidMobile,
    required this.handleCountryCodeChange,
    required this.handleChange,
  }) : super(key: key);

  final BuildContext context;
  final String? mobile;
  final bool isValidCountryCode;
  final bool isValidMobile;
  final void Function(String? p1) handleCountryCodeChange;
  final void Function(String? p1) handleChange;

  @override
  Widget build(BuildContext context) {
    bool isValid = isValidCountryCode && isValidMobile;
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: isValid ? 80.0 : 104.0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:

                /// 輸入的號碼是否符合規則
                isValid

                    /// 符合規則，不需顯示提示訊息
                    ? [
                        RequiresText(context: context, text: '手機'),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            SizedBox(
                                width: 84.0,
                                child: HighlightTextField(
                                    hintText: '+886',
                                    handleChange: handleCountryCodeChange,
                                    isHighlight: false)),
                            const SizedBox(width: 10.0),
                            Expanded(
                                child: HighlightTextField(
                                    hintText: '請輸入手機號碼',
                                    handleChange: handleChange,
                                    isHighlight: false))
                          ],
                        ),
                      ]

                    /// 不符合規則，需顯示提示訊息
                    : [
                        RequiresText(context: context, text: '手機'),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            SizedBox(
                                width: 84.0,
                                child: HighlightTextField(
                                    hintText: '+886',
                                    handleChange: handleCountryCodeChange,
                                    isHighlight: false)),
                            const SizedBox(width: 10.0),
                            Expanded(
                                child: HighlightTextField(
                                    hintText: '請輸入手機號碼',
                                    handleChange: handleChange,
                                    isHighlight: false))
                          ],
                        ),
                        const SizedBox(height: 3.0),
                        ErrorMessage(context: context, message: '請輸入有效手機號碼')
                      ]),
      ),
    );
  }
}
