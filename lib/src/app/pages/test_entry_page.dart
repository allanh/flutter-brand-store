import 'package:brandstores/login_state.dart';
import 'package:brandstores/src/app/pages/static_view.dart';
import 'package:brandstores/src/app/widgets/udi_style/udi_button.dart';
import 'package:brandstores/src/app/widgets/udi_style/udi_tab_bar.dart';
import 'package:brandstores/src/app/widgets/udi_style/email_field.dart';
import 'package:brandstores/src/app/widgets/udi_style/error_text.dart';
import 'package:brandstores/src/app/widgets/udi_style/password_field.dart';
import 'package:brandstores/src/data/utils/dio/api.dart';
import 'package:brandstores/src/data/utils/dio/dio_utils.dart';
import 'package:brandstores/src/data/utils/storage/my_key.dart';
import 'package:brandstores/src/data/utils/storage/secure_storage.dart';
import 'package:brandstores/src/domain/entities/enum/verify_type.dart';
import 'package:brandstores/src/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../widgets/page_indicator.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _storage = SecureStorage();
  String passwordFieldValue = '';

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('API測試'),
          const Divider(),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              createBtn('登入', () => doLogin()),
              createBtn('會員資料', () => getMemberData()),
              createBtn('登出', () => doLogout()),
            ],
          ),
          const SizedBox(height: 50),
          const Text('開發中頁面'),
          const Divider(),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              pushBtn('忘記密碼', forgetPasswordRouteName),
              pushBtn('手機驗證', verifyMobileCodeRouteName, queryParams: {
                "verifyType": VerifyType.resetPassword.value,
                "mobileCode": "886",
                "mobile": "0999999999",
              }),
              pushBtn('變更密碼', resetPasswordRouteName, queryParams: {
                "mobileCode": "886",
                "mobile": "0999999999",
              }),
            ],
          ),
          const SizedBox(height: 50),
          const Text('靜態頁'),
          const Divider(),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              // 靜態頁
              staticPage('預設'),
              staticPage('網站維護', pageType: StaticPageType.maintenance),
              staticPage('網路連線異常', pageType: StaticPageType.noConnection),
              staticPage('500 error', pageType: StaticPageType.error500),
              staticPage('api error', pageType: StaticPageType.apiError),
              staticPage('暫停服務', pageType: StaticPageType.shopClosed),
              // 其它
              staticPage('手機門號停用', pageType: StaticPageType.mobileStop),
              staticPage('電子信箱停用', pageType: StaticPageType.emailStop),
              staticPage('密碼設定成功',
                  pageType: StaticPageType.resetPasswordSuccess),
              staticPage('手機註冊成功',
                  pageType: StaticPageType.mobileRegisterSuccess),
              staticPage('Email註冊成功',
                  pageType: StaticPageType.emailRegisterSuccess),
            ],
          ),
          const SizedBox(height: 50),
          const Text('已完成頁面'),
          const Divider(),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              pushBtn('幫助中心', serviceRouteName),
              pushBtn('常見問題', faqRouteName),
              pushBtn('服務公告', bulletinRouteName),
              pushBtn('會員服務條款', termsRouteName),
              pushBtn('隱私權條款', privacyRouteName),
              pushBtn('關於我們', aboutRouteName),
              pushBtn('登入', loginRouteName),
            ],
          ),
          const SizedBox(height: 50),
          const Text('Widget樣版'),
          const Divider(),
          const Text('PageIndicator: '),
          const PageIndicator(
            selectedIndex: 1,
            itemsCount: 5,
          ),
          const SizedBox(height: 30),
          const Text('ErrorText: '),
          const ErrorText(
              '訊息過長會自動換行，這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字'),
          const ErrorText(
              '限制一行，這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字',
              maxLines: 1),
          const ErrorText(
            '限制二行，這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字',
            maxLines: 2,
          ),
          const ErrorText(
              '一行字尾漸淡，這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字',
              maxLines: 1,
              overflow: TextOverflow.fade),
          const ErrorText(
              '多行字尾漸淡，這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字',
              maxLines: 2,
              overflow: TextOverflow.fade),
          const SizedBox(height: 30),
          const Text('EmailField: '),
          EmailField(
            onFocusChange: (isFocus) =>
                debugPrint('EmailField isFocus：$isFocus'),
            onValueChange: (email) =>
                debugPrint('EmailField input value：$email'),
          ),
          const SizedBox(height: 30),
          const Text('PasswordField: '),
          PasswordField(
            onFocusChange: (isFocus) =>
                debugPrint('PasswordField isFocus：$isFocus'),
            onValueChange: (password) => setState(() {
              debugPrint('PasswordField input value：$password');
              passwordFieldValue = password;
            }),
            errorMessage: passwordFieldValue.isNotEmpty &&
                    !passwordFieldValue.isValidPwd()
                ? '請輸入6-20碼英數字!!! (如果想要調整訊息前後的空白，可以使用paddingStart和paddingEnd)'
                : null,
          ),
          const SizedBox(height: 30),
          const Text('UdiButton: '),
          const UdiButton(text: '不能點擊', onPressed: null),
          UdiButton(text: 'Basic Button', onPressed: () {}),
          UdiButton(
            text: 'Secondary Button',
            onPressed: () {},
            buttonType: ButtonType.secondaryButton,
          ),
          SizedBox(
              width: double.infinity,
              child: UdiButton(text: '滿版按鈕', onPressed: () {})),
          const SizedBox(height: 30),
          const Text('UdiTabBar: Basic Tabs'),
          UdiTabBar(
            const ['Tab1', 'Tab2', 'Tab3'],
            onTap: (tabIndex) => debugPrint('tab click：$tabIndex'),
          ),
          const SizedBox(height: 30),
        ]),
      ));

  Widget staticPage(String buttonName,
      {StaticPageType pageType = StaticPageType.error}) {
    return pushBtn(buttonName, staticRouteName, extra: pageType);
  }

  Widget pushBtn(
    String buttonName,
    String routeName, {
    Map<String, String>? params,
    Map<String, String>? queryParams,
    Object? extra,
  }) {
    return OutlinedButton(
      child: Text(buttonName),
      onPressed: () => context.pushNamed(
        routeName,
        params: params ?? const <String, String>{},
        queryParams: queryParams ?? const <String, String>{},
        extra: extra,
      ),
    );
  }

  Widget openPageBtn(String name, Widget page) {
    return OutlinedButton(
        child: Text(name),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => page)));
  }

  Widget createBtn(String name, VoidCallback fun) {
    return OutlinedButton(child: Text(name), onPressed: fun);
  }

  void doLogin() async {
    final res = await HttpUtils.instance.post(Api.login, params: {
      "mobile_code": "886",
      "mobile": "0955555555",
      "pwd": "Aa123456"
    });
    if (res.isSuccess) {
      var token = res.data["access_token"] as String?;
      if (token != null && token.isNotEmpty) {
        _storage.write(MyKey.auth, token);
        Provider.of<LoginState>(context, listen: false).loggedIn = true;
      }
    }
  }

  void getMemberData() async {
    final res = await HttpUtils.instance.get(Api.memberData);
    if (res.isSuccess) {
      debugPrint('${res.data}');
    }
  }

  void doLogout() {
    _storage.delete(MyKey.auth);
    Provider.of<LoginState>(context, listen: false).loggedIn = false;
  }
}
