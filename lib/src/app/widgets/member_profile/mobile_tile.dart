import 'package:flutter/material.dart';
import 'package:brandstores/src/app/widgets/member_profile/mobile_input_tile.dart';
import 'package:brandstores/src/app/widgets/member_profile/validation_code_tile.dart';
import 'package:brandstores/src/app/widgets/member_profile/mobile_operation_tile.dart';

/// 行動電話區塊
/// - [context] context
/// - [countryCode] 國碼
/// - [mobile] 行動電話
/// - [isVerify] 行動電話是否驗證過
/// - [isValidCountryCode] 國碼是否正確有符合規則
/// - [isValidMobile] 行動電話是否正確有符合規則
/// - [handleCountryCodeChange] 國碼編輯 callback
/// - [handleMobileChange] 行動電話編輯 callback
/// - [handleSendValidationCode] 點擊發送驗證碼按鈕 callback
/// - [handleChangeMobile] 點擊手機變更按鈕 callback
class MobileTile extends StatelessWidget {
  const MobileTile({
    Key? key,
    required bool showValidationView,
    required String? validationCode,
    required this.context,
    required this.countryCode,
    required this.mobile,
    required this.isVerify,
    required this.isValidCountryCode,
    required this.isValidMobile,
    required this.handleCountryCodeChange,
    required this.handleMobileChange,
    required this.handleSendValidationCode,
    required this.handleChangeMobile,
    required this.handleValidationCodeChange,
    required this.handleValidationCodeSubmit,
  })  : _showValidationView = showValidationView,
        _validationCode = validationCode,
        super(key: key);

  final bool _showValidationView;
  final String? _validationCode;
  final BuildContext context;
  final String? countryCode;
  final String? mobile;
  final bool? isVerify;
  final bool isValidCountryCode;
  final bool isValidMobile;
  final void Function(String? p1) handleCountryCodeChange;
  final void Function(String? p1) handleMobileChange;
  final void Function(String? p1) handleSendValidationCode;
  final void Function(String? p1) handleChangeMobile;
  final void Function(String p1)? handleValidationCodeChange;
  final void Function(String? p1) handleValidationCodeSubmit;

  @override
  Widget build(BuildContext context) {
    /// 有行動電話資料，顯示隱碼行動電話
    MobileOperationTile mobileTile = MobileOperationTile(
        showValidationView: _showValidationView,
        context: context,
        sensitiveMobile: mobile ?? '',
        isValidation: isVerify ?? false,
        handleValidCodeSend: handleSendValidationCode,
        handleMobileChange: handleChangeMobile);

    /// 驗證碼輸入欄位
    ValidationCodeTile validationCodeTile = ValidationCodeTile(
        validationCode: _validationCode,
        context: context,
        code: '',
        handleValidationCodeChange: handleValidationCodeChange,
        handleCodeSubmitPressed: handleValidationCodeSubmit);

    /// 沒有行動電話資料，行動電話輸入欄位
    MobileInputTile mobileInputTile = MobileInputTile(
        context: context,
        mobile: mobile,
        isValidCountryCode: isValidCountryCode,
        isValidMobile: isValidMobile,
        handleCountryCodeChange: handleCountryCodeChange,
        handleChange: handleMobileChange);

    return Column(
        children:

            /// 有行動電話資料
            mobile != null

                /// 使用者尚未點擊發送驗證碼按鈕
                ? _showValidationView == false

                    /// 顯示行動電話
                    ? [mobileTile]

                    /// 使用者點擊發送驗證碼按鈕，顯示驗證碼輸入框
                    : [
                        mobileTile,
                        validationCodeTile,
                      ]

                /// 沒有行動電話資料，顯示輸入框
                : [mobileInputTile]);
  }
}
