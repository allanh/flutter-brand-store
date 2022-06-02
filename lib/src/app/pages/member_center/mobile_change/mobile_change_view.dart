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

  bool isShowValidationCodeDescription = true;

  MobileChangeStatus status = MobileChangeStatus.inputPassword;

  Widget _buildDescriptionTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 12.0),
      child: Center(
        child: Text(
          status == MobileChangeStatus.inputPassword
              ? '請輸入密碼以繼續'
              : status == MobileChangeStatus.inputMobile
                  ? '請輸入新的手機門號'
                  : '我們將會發送驗證碼至\n$mobile',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: UdiColors.brownGrey2),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(
      Function handlePasswordSubmit, Function handleMobileSubmit) {
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
            validationCode = text;
            setState(() {
              isShowValidationCodeDescription = false;
            });
          }

          List<Widget> children = [_buildDescriptionTile(context)];

          if (status == MobileChangeStatus.inputPassword) {
            children.addAll([
              PasswordInputTile(
                handlePasswordChange: (text) => handlePasswordChange(text),
              ),
              _buildSubmitButton(handlePasswordSubmit, handleMobileSubmit)
            ]);
          } else if (status == MobileChangeStatus.inputMobile) {
            children.addAll([
              MobileInputTile(
                  handleMobileChange: (text) => handleMobileChange(text)),
              _buildSubmitButton(handlePasswordSubmit, handleMobileSubmit)
            ]);
          } else if (status == MobileChangeStatus.inputValidationCode) {
            children.addAll([
              ValidationCodeInputTile(
                handleValidationCodeChange: (text) =>
                    handleValidationCodeChange(text),
                isShowDescription: isShowValidationCodeDescription,
              ),
              _buildSubmitButton(handlePasswordSubmit, handleMobileSubmit)
            ]);
          }

          return Column(children: children);
        }));
  }
}
