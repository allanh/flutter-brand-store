import 'package:brandstores/src/app/widgets/udi_style/udi_button.dart';
import 'package:brandstores/src/app/widgets/udi_style/udi_tab_bar.dart';
import 'package:brandstores/src/app/widgets/udi_style/email_field.dart';
import 'package:brandstores/src/app/widgets/udi_style/mobile_field.dart';
import 'package:brandstores/src/app/widgets/udi_style/password_field.dart';
import 'package:brandstores/src/data/repositories/data_account_repository.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'login_controller.dart';

class LoginPage extends View {
  LoginPage({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends ViewState<LoginPage, LoginController> {
  _PageState() : super(LoginController(DataAccountRepository()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget get view => Scaffold(
      key: globalKey,
      appBar: AppBar(title: const Text('登入')),
      body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
              key: _formKey,
              child: ControlledWidgetBuilder<LoginController>(
                builder: (context, controller) => _viewBody(controller),
              ))));

  Column _viewBody(LoginController controller) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      UdiTabBar(
        const ['手機號碼', 'Email'],
        onTap: (tabIndex) => setState(() => controller.switchTab(tabIndex)),
      ),
      const SizedBox(height: 16),
      controller.tabIndex == 0 ? _mobileWidget(controller) : _emailWidget(controller),
      const SizedBox(height: 16),
      _passwordWidget(controller),
      _forgetPasswordWidget(controller),
      _loginButtonWidget(controller),
      _registerWidget(controller)
    ]);
  }

  Widget _mobileWidget(LoginController controller) => MobileField(
      defaultValue: controller.inputMobile,
      onValueChange: (mobile) => setState(() => controller.onMobileChange(mobile)),
      onFocusChange: (isFocus) => setState(() => controller.checkMobile()),
      errorMessage: controller.mobileError);

  EmailField _emailWidget(LoginController controller) => EmailField(
      defaultValue: controller.inputEmail,
      onValueChange: (email) => setState(() => controller.onEmailChange(email)),
      onFocusChange: (isFocus) => setState(() => controller.checkEmail()),
      errorMessage: controller.emailError);

  PasswordField _passwordWidget(LoginController controller) => PasswordField(
      onValueChange: (password) => setState(() => controller.onPasswordChange(password)),
      errorMessage: controller.passwordError);

  SizedBox _loginButtonWidget(LoginController controller) => SizedBox(
      width: double.infinity,
      child: UdiButton(
        text: '登入',
        onPressed: controller.isEnableButton ? () => controller.login() : null,
      ));

  Align _forgetPasswordWidget(LoginController controller) => Align(
      alignment: AlignmentDirectional.topEnd,
      child: TextButton(
          onPressed: () => controller.forgotPassword(),
          child: Text('忘記密碼？',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline,
              ))));

  Row _registerWidget(LoginController controller) =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('還不是會員嗎？',
            style: TextStyle(
              color: UdiColors.secondaryText,
              fontWeight: FontWeight.normal,
            )),
        TextButton(
            onPressed: () => controller.register(),
            child: Text('註冊會員',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.underline,
                )))
      ]);
}
