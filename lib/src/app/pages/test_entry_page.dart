import 'package:brandstores/src/data/utils/dio/api.dart';
import 'package:brandstores/src/data/utils/dio/dio_utils.dart';
import 'package:brandstores/src/data/utils/storage/my_key.dart';
import 'package:brandstores/src/data/utils/storage/secure_storage.dart';
import 'package:flutter/material.dart';

import 'helper_center/helper_center_view.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _storage = SecureStorage();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 12),
          const Text('頁面測試'),
          Row(
            children: [
              const SizedBox(width: 12),
              openPageBtn(context, '幫助中心', const HelperCenterPage()),
            ],
          ),
          const SizedBox(height: 50),
          const Text('API測試'),
          Row(
            children: [
              const SizedBox(width: 12),
              createBtn('登入', () => login()),
              const SizedBox(width: 12),
              createBtn('會員資料', () => getMemberData()),
              const SizedBox(width: 12),
              createBtn('登出', () => logout()),
            ],
          ),
        ],
      );

  Widget openPageBtn(BuildContext context, String name, Widget page) {
    return OutlinedButton(
        child: Text(name),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => page)));
  }

  Widget createBtn(String name, VoidCallback fun) {
    return OutlinedButton(child: Text(name), onPressed: fun);
  }

  void login() async {
    final res = await HttpUtils.instance.post(Api.login, params: {
      "mobile_code": "886",
      "mobile": "0955555555",
      "pwd": "Aa123456"
    });
    if (res.isSuccess) {
      var token = res.data["access_token"] as String?;
      if (token != null && token.length > 1) {
        _storage.write(MyKey.auth, token);
      }
    }
  }

  void getMemberData() async {
    final res = await HttpUtils.instance.get(Api.memberData);
    if (res.isSuccess) {
      debugPrint('${res.data}');
    }
  }

  void logout() {
    _storage.delete(MyKey.auth);
  }
}
