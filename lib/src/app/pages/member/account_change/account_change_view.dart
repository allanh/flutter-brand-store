import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:brandstores/src/device/utils/my_plus_colors.dart';

import 'package:brandstores/src/app/pages/member/account_change/account_change_controller.dart';

import 'package:brandstores/src/data/repositories/member/data_account_change_repository.dart';

import 'package:brandstores/src/app/widgets/member/profile/common.dart';

import 'package:brandstores/src/app/widgets/member/account_change/validation_code_input_tile.dart';
import 'package:brandstores/src/app/widgets/member/account_change/password_input_tile.dart';
import 'package:brandstores/src/app/widgets/member/account_change/mobile_input_tile.dart';
import 'package:brandstores/src/app/widgets/member/account_change/email_input_tile.dart';
import 'package:brandstores/src/app/widgets/member/account_change/result_description_view.dart';

enum AccountType { email, mobile }

enum AccountChangeStatus {
  inputPassword,
  inputAccount,
  inputValidationCode,
  registerConflict,
  exceedLimit,
  completed
}

class AccountChangePage extends View {
  AccountChangePage({Key? key, required this.type}) : super(key: key);

  final AccountType type;

  @override
  State<AccountChangePage> createState() => _AccountChangePageState();
}

class _AccountChangePageState
    extends ViewState<AccountChangePage, AccountChangeController> {
  _AccountChangePageState()
      : super(AccountChangeController(DataAccountChangeRepository()));

  String password = '';
  String account = '';
  String validationCode = '';

  AccountChangeStatus status = AccountChangeStatus.inputPassword;

  Widget _buildDescriptionTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 12.0),
      child: Center(
        child: status == AccountChangeStatus.inputPassword
            ? Text(
                '請輸入密碼以繼續',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: UdiColors.brownGrey2),
              )
            : status == AccountChangeStatus.inputAccount
                ? Text(
                    widget.type == AccountType.mobile
                        ? '請輸入新的手機門號'
                        : '請輸入新的電子信箱',
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
                        '+886 ${account.substring(0, 4)}-${account.substring(4, 7)}-${account.substring(7, 10)}',
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
    Function handleAccountSubmit,
    Function handleValidationCodeSubmit,
    Function handleCompleted,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
      child: SizedBox(
        height: 36.0,
        width: MediaQuery.of(context).size.width - 24.0 - 24.0,
        child: ElevatedButton(
          child: const Text('確定'),
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).appBarTheme.backgroundColor),
          onPressed:
              status == AccountChangeStatus.inputPassword && password.length > 5
                  ? () => handlePasswordSubmit(password)
                  : status == AccountChangeStatus.inputAccount &&
                              widget.type == AccountType.mobile &&
                              account.length > 9 ||
                          status == AccountChangeStatus.inputAccount &&
                              widget.type == AccountType.email &&
                              account.isNotEmpty
                      ? () => handleAccountSubmit(account)
                      : status == AccountChangeStatus.inputValidationCode &&
                              validationCode.length == 4
                          ? () => handleValidationCodeSubmit(validationCode)
                          : status == AccountChangeStatus.completed ||
                                  status == AccountChangeStatus.exceedLimit ||
                                  status == AccountChangeStatus.registerConflict
                              ? () => handleCompleted()
                              : null,
        ),
      ),
    );
  }

  @override
  Widget get view {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.type == AccountType.mobile ? '綁定新手機門號' : '綁定新電子信箱'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                status = AccountChangeStatus.inputPassword;
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: ControlledWidgetBuilder<AccountChangeController>(
            builder: (context, controller) {
          void handlePasswordChange(text) {
            setState(() => password = text);
          }

          void handleAccountChange(text) {
            setState(() => account = text);
          }

          void handlePasswordSubmit(text) {
            bool result = controller.handleCheckPassword(password);
            if (result) {
              debugPrint('Pass');
              setState(() {
                status = AccountChangeStatus.inputAccount;
              });
            }
          }

          void handleAccountSubmit(text) {
            bool successful = controller.handleAccountSubmit(text);

            setState(() {
              if (widget.type == AccountType.mobile) {
                status = successful
                    ? AccountChangeStatus.inputValidationCode
                    : AccountChangeStatus.registerConflict;
              } else {
                status = successful
                    ? AccountChangeStatus.completed
                    : AccountChangeStatus.registerConflict;
              }
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
                  ? AccountChangeStatus.completed
                  : result == 'error'
                      ? AccountChangeStatus.exceedLimit
                      : AccountChangeStatus.inputValidationCode;
            });
          }

          void handleResendValidationCode() {}

          void handleCompleted() {
            Navigator.pop(context);
          }

          List<Widget> children = [_buildDescriptionTile(context)];

          if (status == AccountChangeStatus.inputPassword) {
            children.addAll([
              PasswordInputTile(
                handlePasswordChange: (text) => handlePasswordChange(text),
              ),
              _buildSubmitButton(
                handlePasswordSubmit,
                handleAccountSubmit,
                handleValidationCodeSubmit,
                handleCompleted,
              )
            ]);
          } else if (status == AccountChangeStatus.inputAccount &&
              widget.type == AccountType.mobile) {
            children.addAll([
              MobileInputTile(
                  handleMobileChange: (text) => handleAccountChange(text)),
              _buildSubmitButton(
                handlePasswordSubmit,
                handleAccountSubmit,
                handleValidationCodeSubmit,
                handleCompleted,
              )
            ]);
          } else if (status == AccountChangeStatus.inputAccount &&
              widget.type == AccountType.email) {
            bool isValidEmail = controller.validateEmail(account);
            children.addAll(isValidEmail
                ? [
                    EmailInputTile(
                        isValid: isValidEmail,
                        handleEmailChange: (text) => handleAccountChange(text)),
                    _buildSubmitButton(
                      handlePasswordSubmit,
                      handleAccountSubmit,
                      handleValidationCodeSubmit,
                      handleCompleted,
                    )
                  ]
                : [
                    EmailInputTile(
                        isValid: isValidEmail,
                        handleEmailChange: (text) => handleAccountChange(text)),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ErrorMessage(context: context, message: '請輸入有效Email'),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    _buildSubmitButton(
                      handlePasswordSubmit,
                      handleAccountSubmit,
                      handleValidationCodeSubmit,
                      handleCompleted,
                    )
                  ]);
          } else if (status == AccountChangeStatus.inputValidationCode) {
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
                      handleAccountSubmit,
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
                      handleAccountSubmit,
                      handleValidationCodeSubmit,
                      handleCompleted,
                    )
                  ]);
          } else if (status == AccountChangeStatus.exceedLimit) {
            children = [
              ResultDescriptionView(
                  context: context,
                  image: 'assets/images/empty_verification.png',
                  description: '您已經超過本日要求簡訊驗證碼3次',
                  completedButton: _buildSubmitButton(
                    handlePasswordSubmit,
                    handleAccountSubmit,
                    handleValidationCodeSubmit,
                    handleCompleted,
                  ))
            ];
          } else if (status == AccountChangeStatus.completed) {
            children = [
              ResultDescriptionView(
                  context: context,
                  image: 'assets/images/icon_completed_stroke.png',
                  description: widget.type == AccountType.mobile
                      ? '手機綁定變更完成，\n下次請用新的手機門號登入！'
                      : 'Email綁定變更完成。\n下次請用新的電子信箱登入!',
                  completedButton: _buildSubmitButton(
                    handlePasswordSubmit,
                    handleAccountSubmit,
                    handleValidationCodeSubmit,
                    handleCompleted,
                  ))
            ];
          } else if (status == AccountChangeStatus.registerConflict) {
            children = [
              ResultDescriptionView(
                  context: context,
                  image: 'assets/images/empty_error.png',
                  description:
                      '親愛的用戶， 此${widget.type == AccountType.mobile ? '手機門號' : 'Email'}已被註冊過。\n若想繼續，請聯絡客服人員。\n為了保護您的帳戶安全，請填寫真實個人資訊。',
                  completedButton: _buildSubmitButton(
                    handlePasswordSubmit,
                    handleAccountSubmit,
                    handleValidationCodeSubmit,
                    handleCompleted,
                  ))
            ];
          }

          return Column(children: children);
        }));
  }
}
