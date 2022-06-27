import 'package:brandstores/login_state.dart';
import 'package:brandstores/src/app/pages/static_view.dart';
import 'package:brandstores/src/app/widgets/udi_style/address_field.dart';
import 'package:brandstores/src/app/widgets/udi_style/error_text.dart';
import 'package:brandstores/src/app/widgets/udi_style/mobile_field.dart';
import 'package:brandstores/src/app/widgets/udi_style/password_field.dart';
import 'package:brandstores/src/app/widgets/udi_style/udi_button.dart';
import 'package:brandstores/src/app/widgets/udi_style/udi_tab_bar.dart';
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
import '../widgets/udi_style/udi_field.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _storage = SecureStorage();
  String passwordFieldValue = '';
  final String longText = '這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字，這只是一個加了三角型圖案的紅色文字';

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
              createBtn('Storage', () => printStorageData()),
            ],
          ),
          const SizedBox(height: 50),
          const Text('開發中頁面'),
          const Divider(),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              pushBtn('登入', loginRouteName),
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
              pushBtn('預設', staticRouteName),
              pushBtn('網站維護', staticRouteName, extra: StaticPageType.maintenance, queryParams: {
                "message": "預定維護時間：\n2019/11/1 00:00 ~ 2019/11/2 12:00\n如有任何問題歡迎聯繫我們，\n客服人員將誠摯為您服務!",
              }),
              pushBtn('網路連線異常', staticRouteName, extra: StaticPageType.noConnection),
              pushBtn('系統錯誤', staticRouteName, extra: StaticPageType.error500),
              pushBtn('API錯誤', staticRouteName, extra: StaticPageType.apiError),
              pushBtn('暫停服務', staticRouteName, extra: StaticPageType.shopClosed, queryParams: {
                "message": "預定暫停時間：\n2019/11/1  00:00 ~ 2019/11/2  12:00",
              }),
              // 其它
              pushBtn('手機門號停用', staticRouteName, extra: StaticPageType.mobileStop),
              pushBtn('電子信箱停用', staticRouteName, extra: StaticPageType.emailStop),
              pushBtn('密碼設定成功', staticRouteName, extra: StaticPageType.resetPasswordSuccess),
              pushBtn('手機註冊成功', staticRouteName, extra: StaticPageType.mobileRegisterSuccess),
              pushBtn('Email註冊成功', staticRouteName, extra: StaticPageType.emailRegisterSuccess),
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
              pushBtn('忘記密碼', forgetPasswordRouteName),
              pushBtn('手機驗證', verifyMobileCodeRouteName, queryParams: {
                "verifyType": VerifyType.resetPassword.value,
                "mobileCode": "886",
                "mobile": "0999999999",
              }),
              pushBtn('變更密碼(忘記密碼第三步驟)', resetPasswordRouteName, queryParams: {
                "mobileCode": "886",
                "mobile": "0999999999",
              }),
              pushBtn('變更密碼(會員中心)', resetPasswordRouteName),
              pushBtn('註冊頁', registerRouteName),
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
          ErrorText('訊息過長會自動換行，$longText'),
          ErrorText('限制一行，$longText', maxLines: 1),
          ErrorText('限制二行，$longText', maxLines: 2),
          ErrorText('一行字尾漸淡，$longText', maxLines: 1, overflow: TextOverflow.fade),
          ErrorText('多行字尾漸淡，$longText', maxLines: 2, overflow: TextOverflow.fade),
          const SizedBox(height: 30),
          const Text('UdiField: '),
          const UdiField(hintText: '預設樣式'),
          const UdiField(hintText: 'outline樣式', fieldType: FieldType.outline),
          UdiField(
            hintText: '有圖標時',
            startIcon: Icons.email,
            onValueChange: (value) {},
            errorMessage: '有錯誤時',
          ),
          UdiField(
            hintText: 'outline有圖標時',
            startIcon: Icons.email,
            onValueChange: (value) {},
            errorMessage: 'outline錯誤時',
            fieldType: FieldType.outline,
          ),
          const SizedBox(height: 30),
          const Text('MobileField'),
          const MobileField(),
          const SizedBox(height: 30),
          const Text('PasswordField: '),
          PasswordField(
              onFocusChange: (isFocus) => setState(() {}),
              onValueChange: (password) => setState(() => passwordFieldValue = password),
              errorMessage: passwordFieldValue.isNotEmpty && !passwordFieldValue.isValidPwd() ? '請輸入6-20碼英數字' : null),
          const SizedBox(height: 30),
          const Text('AddressField'),
          AddressField(
            defaultZip: '105',
            defaultAddress: '南京東路五段92號3樓',
            onValueChange: (zip, city, area, address) => debugPrint('address: $zip $city $area $address'),
          ),
          const SizedBox(height: 30),
          const AddressField(fieldType: FieldType.outline, errorMessage: "請輸入有效地址"),
          const SizedBox(height: 30),
          const Text('UdiButton: '),
          const UdiButton(text: '不能點擊', onPressed: null),
          UdiButton(text: 'Basic Button', onPressed: () {}),
          UdiButton(
            text: 'Secondary Button',
            onPressed: () {},
            buttonType: ButtonType.secondaryButton,
          ),
          SizedBox(width: double.infinity, child: UdiButton(text: '滿版按鈕', onPressed: () {})),
          const SizedBox(height: 30),
          const Text('UdiTabBar: Basic Tabs'),
          UdiTabBar(
            const ['Tab1', 'Tab2', 'Tab3'],
            onTap: (tabIndex) => debugPrint('tab click：$tabIndex'),
          ),
          const SizedBox(height: 30),
        ]),
      ));

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
    return OutlinedButton(child: Text(name), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)));
  }

  Widget createBtn(String name, VoidCallback fun) {
    return OutlinedButton(child: Text(name), onPressed: fun);
  }

  void doLogin() async {
    final res = await HttpUtils.instance.post(Api.login, params: {"mobile_code": "886", "mobile": "0955555555", "pwd": "Aa123456"});
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

  void printStorageData() {
    _storage.readAll().then((value) => value.forEach((key, value) => debugPrint('storage => $key: $value')));
  }
}
