import 'package:brandstores/src/app/widgets/udi_style/mobile_field.dart';
import 'package:brandstores/src/app/widgets/udi_style/password_field.dart';
import 'package:brandstores/src/app/widgets/udi_style/udi_button.dart';
import 'package:brandstores/src/app/widgets/udi_style/udi_field.dart';
import 'package:brandstores/src/app/widgets/udi_style/udi_tab_bar.dart';
import 'package:brandstores/src/data/repositories/data_account_repository.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants.dart';
import '../../../widgets/udi_style/address_field.dart';
import 'register_controller.dart';

class RegisterPage extends View {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends ViewState<RegisterPage, RegisterController> {
  _PageState() : super(RegisterController(DataAccountRepository()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget get view => Scaffold(
      key: globalKey,
      appBar: AppBar(title: const Text('註冊')),
      body: Form(
          key: _formKey,
          child: ControlledWidgetBuilder<RegisterController>(
            builder: (context, controller) => Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: _viewBody(controller),
                  ),
                ),
                _termsAndPrivacy(controller)
              ],
            ),
          )));

  Widget _termsAndPrivacy(RegisterController controller) => ColoredBox(
        color: UdiColors.white2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('註冊帳號即表示你同意', style: secondaryTextStyle),
            _getTextButton('會員服務條款', termsRouteName),
            Text('與', style: secondaryTextStyle),
            _getTextButton('隱私權條款', privacyRouteName),
          ],
        ),
      );

  TextButton _getTextButton(String text, String routeName) => TextButton(
        onPressed: () => context.pushNamed(routeName),
        child: Text(text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.underline,
            )),
      );

  TextStyle get secondaryTextStyle => const TextStyle(
        fontSize: 14,
        color: UdiColors.secondaryText,
        fontWeight: FontWeight.normal,
      );

  Widget _viewBody(RegisterController controller) => Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(children: [
            UdiTabBar(const ['手機號碼', 'Email'], onTap: (tabIndex) => setState(() => controller.switchTab(tabIndex))),
            const SizedBox(height: 16),
            _nameField(controller),
            const SizedBox(height: 16),
            controller.tabIndex == 0 ? _mobileWidget(controller) : _emailWidget(controller),
            const SizedBox(height: 16),
            _passwordField(controller),
            const SizedBox(height: 16),
            _passwordConfirmField(controller),
            const SizedBox(height: 16),
            _gender(context, controller),
            const SizedBox(height: 16),
            GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    maxTime: DateTime.now(),
                    locale: LocaleType.tw,
                    onConfirm: (date) => setState(()=> controller.onBirthdayChange(date)),
                  );
                },
                child: const UdiField(
                  hintText: '請選擇生日',
                  enabled: false,
                  suffixIcon: Image(image: AssetImage('assets/images/icon_date_picker.png')),
                )),
            const SizedBox(height: 16),
            AddressField(
              onValueChange: (zip, city, area, address) => controller.onAddressChange(zip, city, area, address),
            ),
            const SizedBox(height: 24),
            _submitButton(controller),
          ]),
        );
      });

  UdiField _nameField(RegisterController controller) => UdiField(
      hintText: '請輸入姓名',
      maxLength: 20,
      onValueChange: (value) => setState(() => controller.onNameChange(value)),
      onFocusChange: (isFocus) => setState(() => controller.checkName()),
      errorMessage: controller.nameError);

  Widget _mobileWidget(RegisterController controller) => MobileField(
      defaultValue: controller.mobile,
      onValueChange: (mobile) => setState(() => controller.onMobileChange(mobile)),
      onFocusChange: (isFocus) => setState(() => controller.checkMobile()),
      errorMessage: controller.mobileError);

  Widget _emailWidget(RegisterController controller) => UdiField(
      hintText: '請輸入Email',
      defaultValue: controller.email,
      onValueChange: (email) => setState(() => controller.onEmailChange(email)),
      onFocusChange: (isFocus) => setState(() => controller.checkEmail()),
      errorMessage: controller.emailError);

  Widget _passwordField(RegisterController controller) => PasswordField(
      hintText: '請輸入6-20碼英數字',
      onValueChange: (value) => setState(() => controller.onPasswordChange(value)),
      onFocusChange: (isFocus) => setState(() => controller.checkMobile()),
      errorMessage: controller.passwordError);

  Widget _passwordConfirmField(RegisterController controller) => PasswordField(
      hintText: '再次輸入密碼',
      onValueChange: (value) => setState(() => controller.onPasswordConfirmChange(value)),
      onFocusChange: (isFocus) => setState(() => controller.checkMobile()),
      errorMessage: controller.passwordConfirmError);

  Row _gender(BuildContext context, RegisterController controller) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          getRadio('M', controller),
          Text('男性', style: textStyle),
          const SizedBox(width: 12),
          getRadio('F', controller),
          Text('女性', style: textStyle),
          const SizedBox(width: 12),
          getRadio('O', controller),
          Text('不公開', style: textStyle),
        ],
      );

  TextStyle get textStyle => const TextStyle(color: UdiColors.normalText, fontWeight: FontWeight.normal);

  Radio getRadio(String radioValue, RegisterController controller) => Radio(
        value: radioValue,
        onChanged: (value) => setState(() => controller.gender = value.toString()),
        groupValue: controller.gender,
        activeColor: Theme.of(context).primaryColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      );

  SizedBox _submitButton(RegisterController controller) => SizedBox(
      width: double.infinity,
      child: UdiButton(
        text: '註冊',
        onPressed: controller.isEnableButton ? () => controller.checkAccountStatus() : null,
      ));
}
