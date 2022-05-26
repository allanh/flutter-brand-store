import 'package:brandstores/src/app/widgets/udi_style/udi_button.dart';
import 'package:brandstores/src/app/widgets/udi_style/udi_tab_bar.dart';
import 'package:brandstores/src/app/widgets/udi_style/email_field.dart';
import 'package:brandstores/src/app/widgets/udi_style/mobile_field.dart';
import 'package:brandstores/src/data/repositories/data_account_repository.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'forget_password_controller.dart';

class ForgetPasswordPage extends View {
  ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends ViewState<ForgetPasswordPage, ForgetPasswordController> {
  _PageState() : super(ForgetPasswordController(DataAccountRepository()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget get view => Scaffold(
      key: globalKey,
      appBar: AppBar(title: const Text('忘記密碼')),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
          child: Form(
              key: _formKey,
              child: ControlledWidgetBuilder<ForgetPasswordController>(
                builder: (context, controller) => _viewBody(controller),
              ))));

  Column _viewBody(ForgetPasswordController controller) => Column(children: [
        const Text('請輸入您的會員帳號，以接收密碼', style: TextStyle(color: UdiColors.secondaryText)),
        const SizedBox(height: 24),
        UdiTabBar(const ['手機號碼', 'Email'],
            onTap: (tabIndex) => setState(() => controller.switchTab(tabIndex))),
        const SizedBox(height: 16),
        controller.tabIndex == 0 ? _mobileWidget(controller) : _emailWidget(controller),
        const SizedBox(height: 24),
        _submitButton(controller),
      ]);

  Widget _mobileWidget(ForgetPasswordController controller) => MobileField(
      defaultValue: controller.inputMobile,
      onValueChange: (mobile) => controller.onMobileChange(mobile),
      onFocusChange: (isFocus) => controller.checkMobile(),
      errorMessage: controller.mobileError);

  Widget _emailWidget(ForgetPasswordController controller) => EmailField(
      defaultValue: controller.inputEmail,
      onValueChange: (email) => controller.onEmailChange(email),
      onFocusChange: (isFocus) => controller.checkEmail(),
      errorMessage: controller.emailError);

  SizedBox _submitButton(ForgetPasswordController controller) => SizedBox(
      width: double.infinity,
      child: UdiButton(
          text: '確定',
          onPressed: controller.isEnableButton ? () => controller.sendVerification() : null));
}
