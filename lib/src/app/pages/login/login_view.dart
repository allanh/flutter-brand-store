import 'package:brandstores/src/data/repositories/data_account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'login_controller.dart';

class LoginPage extends View {
  LoginPage({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends ViewState<LoginPage, LoginController>
    with SingleTickerProviderStateMixin {
  _PageState() : super(LoginController(DataAccountRepository()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void showToast(String message) {
    WidgetsBinding.instance?.addPostFrameCallback((_) =>
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message))));
  }

  @override
  Widget get view => Scaffold(
      appBar: AppBar(title: const Text('登入')),
      body: ControlledWidgetBuilder<LoginController>(
          builder: ((context, controller) {
        if (controller.isLoginSuccess) {
          showToast('登入成功');
          Navigator.pop(context);
          // } else if (controller.showApiError == true &&
          //     controller.apiErrorMessage != null) {
          //   showToast(controller.apiErrorMessage ?? '');
        }
        return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              _tabBar(controller),
              const SizedBox(height: 16),
              Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _tabController.index == 0
                            ? _mobileWidget(controller)
                            : _emailWidget(controller),
                        const SizedBox(height: 16),
                        _passwordWidget(controller),
                        const SizedBox(height: 4),
                        _passwordErrorWidget(controller),
                        Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: TextButton(
                                child: Text(
                                  '忘記密碼？',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                                onPressed: () {})),
                        SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: controller.isEnableLoginButton
                                  ? () => controller.login()
                                  : null,
                              child: const Text('登入'),
                              style:
                                  loginBtnStyle(controller.isEnableLoginButton),
                            )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('還不是會員嗎？'),
                              TextButton(
                                child: Text('註冊會員',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        decoration: TextDecoration.underline)),
                                onPressed: () {},
                              )
                            ])
                      ]))
            ]));
      })));

  ButtonStyle loginBtnStyle(bool isEnable) => isEnable
      ? OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          side: BorderSide(color: Theme.of(context).primaryColor),
        )
      : OutlinedButton.styleFrom(
          primary: const Color(0xffb4b4b4),
          backgroundColor: const Color(0xfff2f2f2),
          side: const BorderSide(color: Color(0xffe5e5e5)),
        );

  TabBar _tabBar(LoginController controller) {
    return TabBar(
      controller: _tabController,
      labelColor: const Color(0xff7f7f7f),
      unselectedLabelColor: const Color(0xff7f7f7f),
      indicator: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xff7f7f7f), width: 2)),
      ),
      onTap: (tabIndex) => setState(() {
        controller.switchTabIndex(tabIndex);
      }),
      tabs: const [
        Tab(text: '手機號碼'),
        Tab(text: 'Email'),
      ],
    );
  }

  Row _mobileWidget(LoginController controller) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              child: const Text('+886', style: TextStyle(fontSize: 16)),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xffe5e5e5), width: 2)))),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
            children: [
              Focus(
                onFocusChange: (hasFocus) => controller.checkMobile(),
                child: TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    controller: controller.mobileTextController,
                    decoration: InputDecoration(
                      hintText: '請輸入手機號碼',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      errorText: controller.showMobileError ? '' : null,
                      errorBorder: _errorBorder(),
                      focusedBorder: _focusedBorder(),
                      border: _defaultBorder(),
                      errorStyle:
                          const TextStyle(height: 0, color: Colors.transparent),
                    )),
              ),
              _mobileErrorWidget(controller)
            ],
          ))
        ]);
  }

  Widget _emailWidget(LoginController controller) => Column(
        children: [
          Focus(
            onFocusChange: (hasFocus) => controller.checkEmail(),
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email, color: Color(0xff7F7F7F)),
                  hintText: '請輸入Email',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  errorText: controller.showEmailError ? '' : null,
                  errorBorder: _errorBorder(),
                  focusedBorder: _focusedBorder(),
                  border: _defaultBorder(),
                  errorStyle:
                      const TextStyle(height: 0, color: Colors.transparent),
                )),
          ),
          const SizedBox(height: 4),
          _emailErrorWidget(controller)
        ],
      );

  TextFormField _passwordWidget(LoginController controller) => TextFormField(
      keyboardType: TextInputType.text,
      controller: controller.passwordTextController,
      obscureText: !controller.passwordVisible,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock, color: Color(0xff7F7F7F)),
          hintText: '請輸入密碼',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          errorText: controller.showApiError ? '' : null,
          border: _defaultBorder(),
          errorBorder: _errorBorder(),
          focusedBorder: _focusedBorder(),
          errorStyle: const TextStyle(height: 0, color: Colors.transparent),
          suffixIcon: IconButton(
            icon: Icon(
                controller.passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: const Color(0xff7F7F7F)),
            onPressed: () => setState(() => controller.switchPasswordIcon()),
          )));

  UnderlineInputBorder _defaultBorder() => const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffe5e5e5)));

  UnderlineInputBorder _focusedBorder() => const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff4c4c4c)));

  UnderlineInputBorder _errorBorder() => const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xfff23f44)));

  Visibility _mobileErrorWidget(LoginController controller) => Visibility(
      visible: controller.showMobileError,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        Icon(Icons.warning_rounded, color: Color(0xfff23f44), size: 18),
        SizedBox(width: 4),
        Flexible(
            child:
                Text('請輸入有效手機號碼', style: TextStyle(color: Color(0xfff23f44))))
      ]));

  Visibility _emailErrorWidget(LoginController controller) => Visibility(
      visible: controller.showEmailError,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        SizedBox(width: 16),
        Icon(Icons.warning_rounded, color: Color(0xfff23f44), size: 18),
        SizedBox(width: 4),
        Flexible(
            child:
                Text('請輸入有效Email', style: TextStyle(color: Color(0xfff23f44))))
      ]));

  Visibility _passwordErrorWidget(LoginController controller) => Visibility(
      visible: controller.showApiError,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(width: 16),
        const Icon(Icons.warning_rounded, color: Color(0xfff23f44), size: 18),
        const SizedBox(width: 4),
        Flexible(
            child: Text(controller.apiErrorMessage ?? '',
                style: const TextStyle(color: Color(0xfff23f44))))
      ]));
}
