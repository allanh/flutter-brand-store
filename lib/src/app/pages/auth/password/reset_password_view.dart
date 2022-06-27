import 'package:brandstores/src/app/widgets/udi_style/udi_button.dart';
import 'package:brandstores/src/data/repositories/data_account_repository.dart';
import 'package:brandstores/src/domain/entities/enum/verify_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../widgets/udi_style/password_field.dart';
import 'reset_password_controller.dart';

class ResetPasswordPage extends View {
  ResetPasswordPage(this.verifyMethod, {Key? key, this.mobileCode = '886', this.mobile, this.email})
      : super(key: key);
  final VerifyMethod verifyMethod;
  final String mobileCode;
  final String? mobile;
  final String? email;

  String getMobileCode() => mobileCode.replaceAllMapped(RegExp(r'\+?(\d{3})'), (match) {
        return '${match.group(1)}';
      });

  @override
  // ignore: no_logic_in_create_state
  _PageState createState() => _PageState(verifyMethod);
}

class _PageState extends ViewState<ResetPasswordPage, ResetPasswordController> {
  _PageState(verifyMethod) : super(ResetPasswordController(DataAccountRepository(), verifyMethod));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget get view => Scaffold(
      key: globalKey,
      appBar: AppBar(title:  Text(widget.verifyMethod == VerifyMethod.password ? '修改密碼' : '忘記密碼')),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
          child: Form(
              key: _formKey,
              child: ControlledWidgetBuilder<ResetPasswordController>(
                builder: (context, controller) => _viewBody(controller),
              ))));

  Column _viewBody(ResetPasswordController controller) {
    return Column(
      children: [
        const SizedBox(height: 36),
        _oldPasswordWidget(controller),
        _passwordWidget(controller),
        _passwordConfirmWidget(controller),
        const SizedBox(height: 24),
        _submitButton(controller),
      ],
    );
  }

  Widget _oldPasswordWidget(ResetPasswordController controller) {
    return Visibility(
      visible: widget.verifyMethod == VerifyMethod.password,
      child: PasswordField(
        onValueChange: (value) => setState(() => controller.onOldPasswordChange(value)),
        hintText: '請輸入現在的密碼',
        errorMessage: controller.oldPasswordError,
      ),
    );
  }

  Widget _passwordWidget(ResetPasswordController controller) {
    return PasswordField(
      onValueChange: (value) => setState(() => controller.onPasswordChange(value)),
      hintText: '請輸入密碼6-20碼英數字',
    );
  }

  Widget _passwordConfirmWidget(ResetPasswordController controller) {
    return PasswordField(
      onValueChange: (value) => setState(() => controller.onPasswordConfirmChange(value)),
      hintText: '再次輸入密碼',
      errorMessage: controller.errorMessage,
    );
  }

  SizedBox _submitButton(ResetPasswordController controller) {
    return SizedBox(
        width: double.infinity,
        child: UdiButton(
          text: '確定',
          onPressed: controller.isEnableButton
              ? () => controller.modifyPassword(widget.getMobileCode(), widget.mobile, widget.email)
              : null,
        ));
  }
}
