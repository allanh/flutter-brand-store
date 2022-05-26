import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/udi_style/udi_button.dart';

class StaticPage extends StatelessWidget {
  final String? title;
  final String? message;
  final StaticPageType pageType;

  const StaticPage({
    Key? key,
    this.pageType = StaticPageType.error,
    this.title,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //TODO: 為了測時方便，暫時加上AppBar，之後要拿掉(即不能Back)
        appBar: AppBar(title: Text(pageType.name)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: _body(context),
        ));
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(pageType.icon),
        Text(
          title ?? pageType.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            color: UdiColors.normalText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
          width: double.infinity,
        ),
        Text(message ?? pageType.content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: UdiColors.secondaryText,
              fontWeight: FontWeight.normal,
            )),
        const SizedBox(height: 20),
        Visibility(
            visible: pageType == StaticPageType.error500,
            child: UdiButton(
              text: '重新載入頁面',
              onPressed: () => context.goNamed(rootRouteName),
            )),
        Visibility(
            visible: pageType == StaticPageType.apiError,
            child: Row(
              children: [
                UdiButton(
                  text: '前往首頁',
                  onPressed: () => context.goNamed(rootRouteName),
                  buttonType: ButtonType.secondaryButton,
                ),
                const SizedBox(width: 20),
                UdiButton(text: '回上一頁', onPressed: () => context.pop()),
              ],
            )),
        // 門號註冊成功: 首頁
        Visibility(
            visible: pageType == StaticPageType.mobileRegisterSuccess,
            child: UdiButton(
                text: '來去逛逛',
                buttonType: ButtonType.secondaryButton,
                onPressed: () => context.goNamed(rootRouteName))),
        // 電子信箱註冊成功: 登入頁
        Visibility(
            visible: pageType == StaticPageType.emailRegisterSuccess ||
                pageType == StaticPageType.resetPasswordSuccess,
            child: UdiButton(
                text: '重新登入',
                buttonType: ButtonType.secondaryButton,
                onPressed: () => context.goNamed(loginRouteName))),
        // 帳號停用: 登入頁
        Visibility(
            visible: pageType == StaticPageType.mobileStop || pageType == StaticPageType.emailStop,
            child: UdiButton(
              text: '確定',
              onPressed: () => context.goNamed(loginRouteName),
            )),
      ],
    );
  }
}

enum StaticPageType {
  // 靜態頁
  maintenance,
  noConnection,
  error500,
  apiError,
  shopClosed,
  // 其它
  mobileStop,
  emailStop,
  mobileRegisterSuccess,
  emailRegisterSuccess,
  resetPasswordSuccess,
  error,
}

extension _StaticPageTypeExtension on StaticPageType {
  String get icon {
    switch (this) {
      case StaticPageType.maintenance:
        return 'assets/images/static_maintenance.png';
      case StaticPageType.noConnection:
        return 'assets/images/static_no_connection.png';
      case StaticPageType.error500:
      case StaticPageType.apiError:
        return 'assets/images/static_error500.png';
      case StaticPageType.shopClosed:
        return 'assets/images/static_shop_closed.png';
      case StaticPageType.mobileStop:
        return 'assets/images/empty_phone_number.png';
      case StaticPageType.emailStop:
        return 'assets/images/empty_verification.png';
      case StaticPageType.mobileRegisterSuccess:
      case StaticPageType.emailRegisterSuccess:
      case StaticPageType.resetPasswordSuccess:
        return 'assets/images/all_completed.png';
      case StaticPageType.error:
        return 'assets/images/empty_search.png';
    }
  }

  String get title {
    switch (this) {
      case StaticPageType.maintenance:
        return '系統維護中！\n為提供您更好的體驗，\n我們正在進行服務更新，\n敬請期待！';
      case StaticPageType.noConnection:
        return '網路異常';
      case StaticPageType.error500:
        return '500 ERROR\n哦喔～出了一點小狀況⋯⋯\n請稍候再試。';
      case StaticPageType.apiError:
        return '哦喔～出了一點小狀況⋯⋯\n請稍候再試。';
      case StaticPageType.shopClosed:
        return '品牌商店名稱\n暫停服務';
      default:
        return '';
    }
  }

  String get content {
    switch (this) {
      case StaticPageType.maintenance:
        return '預定維護時間：\n2019/11/1 00:00 ~ 2019/11/2 12:00\n如有任何問題歡迎聯繫我們，\n客服人員將誠摯為您服務!';
      case StaticPageType.noConnection:
        return '網路連線異常，請確認網路連線狀態。';
      case StaticPageType.error500:
        return '您可以重新載入頁面。';
      case StaticPageType.apiError:
        return '您可以前往首頁或返回上一頁。';
      case StaticPageType.shopClosed:
        return '預定暫停時間：\n2019/11/1  00:00 ~ 2019/11/2  12:00';
      case StaticPageType.mobileStop:
        return '帳號登入異常，請聯絡客服人員。';
      case StaticPageType.emailStop:
        return '帳號登入異常，請聯絡客服人員。';
      case StaticPageType.mobileRegisterSuccess:
        return '完成註冊！';
      case StaticPageType.emailRegisterSuccess:
        return '註冊成功！\n請前往電子信箱收取驗證信';
      case StaticPageType.resetPasswordSuccess:
        return '密碼設定成功';
      case StaticPageType.error:
      default:
        return '';
    }
  }
}

extension ToStaticPageTypeExtension on String {
  StaticPageType get toStaticPageType {
    for (var type in StaticPageType.values) {
      if (this == type.name) return type;
    }
    return StaticPageType.error;
  }
}
