import 'package:brandstores/src/app/widgets/member_center/member_profile/common.dart';
import 'package:brandstores/src/app/widgets/member_center/mobile_change/validation_code_input_tile.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:brandstores/src/app/pages/member_center/mobile_change/mobile_change_controller.dart';
import 'package:brandstores/src/data/repositories/data_mobile_change_repository.dart';

import 'package:brandstores/src/app/widgets/member_center/mobile_change/password_input_tile.dart';
import 'package:brandstores/src/app/widgets/member_center/mobile_change/mobile_input_tile.dart';

enum MobileChangeStatus {
  inputPassword,
  inputMobile,
  inputValidationCode,
  exceedLimit,
  completed
}

class MobileChangePage extends View {
  MobileChangePage({Key? key}) : super(key: key);

  @override
  State<MobileChangePage> createState() => _MobileChangePageState();
}

class _MobileChangePageState
    extends ViewState<MobileChangePage, MobileChangeController> {
  _MobileChangePageState()
      : super(MobileChangeController(DataMobileChangeRepository()));

  String password = '';
  String mobile = '';
  String validationCode = '';

  MobileChangeStatus status = MobileChangeStatus.inputPassword;

  Widget _buildDescriptionTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 12.0),
      child: Center(
        child: status == MobileChangeStatus.inputPassword
            ? Text(
                '請輸入密碼以繼續',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: UdiColors.brownGrey2),
              )
            : status == MobileChangeStatus.inputMobile
                ? Text(
                    '請輸入新的手機門號',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: UdiColors.brownGrey2),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '我們將會發送驗證碼至',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: UdiColors.brownGrey),
                      ),
                      const SizedBox(height: 9.0),
                      Text(
                        '+886 ${mobile.substring(0, 4)}-${mobile.substring(4, 7)}-${mobile.substring(7, 10)}',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: UdiColors.greyishBrown),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _buildSubmitButton(
      Function handlePasswordSubmit,
      Function handleMobileSubmit,
      Function handleValidationCodeSubmit,
      Function handleCompleted) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
      child: SizedBox(
        height: 36.0,
        width: MediaQuery.of(context).size.width - 24.0 - 24.0,
        child: ElevatedButton(
            child: const Text('確定'),
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).appBarTheme.backgroundColor),
            onPressed: status == MobileChangeStatus.inputPassword &&
                    password.length > 5
                ? () => handlePasswordSubmit(password)
                : status == MobileChangeStatus.inputMobile && mobile.length > 9
                    ? () => handleMobileSubmit(mobile)
                    : status == MobileChangeStatus.inputValidationCode &&
                            validationCode.length == 4
                        ? () => handleValidationCodeSubmit(validationCode)
                        : status == MobileChangeStatus.completed ||
                                status == MobileChangeStatus.exceedLimit
                            ? () => handleCompleted()
                            : null),
      ),
    );
  }

  @override
  Widget get view {
    return Scaffold(
        appBar: AppBar(
          title: const Text('綁定新手機門號'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                status = MobileChangeStatus.inputPassword;
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: ControlledWidgetBuilder<MobileChangeController>(
            builder: (context, controller) {
          void handlePasswordChange(text) {
            setState(() => password = text);
          }

          void handleMobileChange(text) {
            setState(() => mobile = text);
          }

          void handlePasswordSubmit(text) {
            bool result = controller.handleCheckPassword(password);
            if (result) {
              debugPrint('Pass');
              setState(() {
                status = MobileChangeStatus.inputMobile;
              });
            }
          }

          void handleMobileSubmit(text) {
            setState(() {
              status = MobileChangeStatus.inputValidationCode;
            });
          }

          void handleValidationCodeChange(text) {
            setState(() {
              validationCode = text;
            });
          }

          void handleValidationCodeSubmit(code) {
            String result = controller.handleValidationCodeSubmit(code);
            setState(() {
              status = result.isEmpty
                  ? MobileChangeStatus.completed
                  : result == 'error'
                      ? MobileChangeStatus.exceedLimit
                      : MobileChangeStatus.inputValidationCode;
            });
          }

          void handleResendValidationCode() {}

          void handleCompleted() {
            Navigator.pop(context);
          }

          List<Widget> children = [_buildDescriptionTile(context)];

          if (status == MobileChangeStatus.inputPassword) {
            children.addAll([
              PasswordInputTile(
                handlePasswordChange: (text) => handlePasswordChange(text),
              ),
              _buildSubmitButton(
                handlePasswordSubmit,
                handleMobileSubmit,
                handleValidationCodeSubmit,
                handleCompleted,
              )
            ]);
          } else if (status == MobileChangeStatus.inputMobile) {
            children.addAll([
              MobileInputTile(
                  handleMobileChange: (text) => handleMobileChange(text)),
              _buildSubmitButton(
                handlePasswordSubmit,
                handleMobileSubmit,
                handleValidationCodeSubmit,
                handleCompleted,
              )
            ]);
          } else if (status == MobileChangeStatus.inputValidationCode) {
            bool isValidCode = controller.isValidCode(validationCode);
            children.addAll(isValidCode
                ? [
                    ValidationCodeInputTile(
                      isValid: isValidCode,
                      handleValidationCodeChange: (text) =>
                          handleValidationCodeChange(text),
                    ),
                    _buildSubmitButton(
                      handlePasswordSubmit,
                      handleMobileSubmit,
                      handleValidationCodeSubmit,
                      handleCompleted,
                    )
                  ]
                : [
                    ValidationCodeInputTile(
                      isValid: isValidCode,
                      handleValidationCodeChange: (text) =>
                          handleValidationCodeChange(text),
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ErrorMessage(context: context, message: '驗證碼錯誤，請重新輸入'),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 36.0,
                          width:
                              MediaQuery.of(context).size.width - 24.0 - 24.0,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                                primary: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor),
                            child: const Text('重新取得驗證碼'),
                            onPressed: handleResendValidationCode,
                          ),
                        ),
                      ],
                    ),
                    _buildSubmitButton(
                      handlePasswordSubmit,
                      handleMobileSubmit,
                      handleValidationCodeSubmit,
                      handleCompleted,
                    )
                  ]);
          } else if (status == MobileChangeStatus.exceedLimit) {
            children = [
              Padding(
                padding: const EdgeInsets.only(top: 112.0),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 120.0,
                        height: 120.0,
                        child: Image(
                            image: AssetImage(
                                'assets/images/empty_verification.png')),
                      ),
                      const SizedBox(height: 22.0),
                      SizedBox(
                        height: 44.0,
                        child: Text('您已經超過本日要求簡訊驗證碼3次',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: UdiColors.brownGrey)),
                      ),
                      _buildSubmitButton(
                        handlePasswordSubmit,
                        handleMobileSubmit,
                        handleValidationCodeSubmit,
                        handleCompleted,
                      )
                    ],
                  ),
                ),
              )
            ];
          } else if (status == MobileChangeStatus.completed) {
            children = [
              Padding(
                padding: const EdgeInsets.only(top: 112.0),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 120.0,
                        height: 120.0,
                        child: Image(
                            image: AssetImage(
                                'assets/images/icon_completed_stroke.png')),
                      ),
                      const SizedBox(height: 22.0),
                      SizedBox(
                        height: 44.0,
                        child: Text('手機綁定變更完成，\n下次請用新的手機門號登入！',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: UdiColors.brownGrey)),
                      ),
                      _buildSubmitButton(
                        handlePasswordSubmit,
                        handleMobileSubmit,
                        handleValidationCodeSubmit,
                        handleCompleted,
                      )
                    ],
                  ),
                ),
              )
            ];
          }

          return Column(children: children);
        }));
  }
}
