import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';

/// 建立驗證碼輸入匡
/// - [context] context
/// - [code] 驗證碼
/// - [handleValidationCodeChange] 驗證碼編輯 callback
/// - [handleCodeSubmitPressed] 驗證碼提交 callback
class ValidationCodeTile extends StatelessWidget {
  const ValidationCodeTile({
    Key? key,
    required String? validationCode,
    required this.context,
    required this.code,
    required this.handleValidationCodeChange,
    required this.handleCodeSubmitPressed,
  })  : _validationCode = validationCode,
        super(key: key);

  final String? _validationCode;
  final BuildContext context;
  final String? code;
  final void Function(String p1)? handleValidationCodeChange;
  final void Function(String? p1) handleCodeSubmitPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 104.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                    child: TextField(
                        onChanged: handleValidationCodeChange,
                        cursorColor: UdiColors.brownGrey2,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0,
                                    color: (false)
                                        ? UdiColors.strawberry
                                        : UdiColors.veryLightGrey2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0,
                                    color: (false)
                                        ? UdiColors.strawberry
                                        : UdiColors.veryLightGrey2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0,
                                    color: (false)
                                        ? UdiColors.strawberry
                                        : UdiColors.veryLightGrey2)),
                            hintText: '請輸入驗證碼',
                            hintStyle:
                                const TextStyle(color: UdiColors.brownGrey2),
                            contentPadding: const EdgeInsets.only(
                              left: 10.0,
                              top: 40.0 / 4,
                              bottom: 40.0 / 4,
                            )))),
                const SizedBox(width: 12.0),
                SizedBox(
                    width: 80.0,
                    height: 40.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary:
                                Theme.of(context).appBarTheme.backgroundColor),
                        onPressed: () =>
                            handleCodeSubmitPressed(_validationCode),
                        child: const Text('提交')))
              ]),
              const SizedBox(height: 4.0),
              Text('請耐心等候驗證簡訊，約300秒後可重新發送。',
                  style: TextStyle(
                      color: UdiColors.brownGrey2,
                      fontFamily: 'PingFangTC Regular',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0))
            ])));
  }
}
