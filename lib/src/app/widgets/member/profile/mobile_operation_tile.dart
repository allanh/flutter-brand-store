import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/app/widgets/member/profile/common.dart';

/// 建立行動電話操作區塊
/// - [sensitiveMobile] 行動電話隱碼
/// - [isValidation] 號碼是否符合規則
/// - [handleValidCodeSend] 點擊發送驗證碼 callback
/// - [handleMobileChange] 號碼編輯 callback
class MobileOperationTile extends StatelessWidget {
  const MobileOperationTile({
    Key? key,
    required bool showValidationView,
    required this.context,
    required this.sensitiveMobile,
    required this.isValidation,
    required this.handleValidCodeSend,
    required this.handleMobileChange,
  })  : _showValidationView = showValidationView,
        super(key: key);

  final bool _showValidationView;
  final BuildContext context;
  final String sensitiveMobile;
  final bool isValidation;
  final void Function(String? p1) handleValidCodeSend;
  final void Function(String? p1) handleMobileChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 80.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RequiresText(context: context, text: '手機'),
              const SizedBox(height: 8.0),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Text(sensitiveMobile,
                          style: const TextStyle(
                              color: UdiColors.greyishBrown,
                              fontFamily: 'PingFangTC Regular',
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0)),
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
                                HyperLinkButton(
                                    context: context,
                                    text: '手機變更',
                                    enable: true,
                                    handleTap: handleMobileChange)
                              ]
                            : [
                                HyperLinkButton(
                                    context: context,
                                    text: '發送驗證碼',
                                    enable: _showValidationView == false,
                                    handleTap: handleValidCodeSend),
                                const SizedBox(width: 4),
                                HyperLinkButton(
                                    context: context,
                                    text: '手機變更',
                                    enable: true,
                                    handleTap: handleMobileChange)
                              ])
                  ])
            ])));
  }
}
