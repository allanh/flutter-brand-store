import 'package:brandstores/src/domain/entities/enum/verify_type.dart';
import 'package:brandstores/src/domain/entities/member/shipping_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../login_state.dart';
import '../app/main/main_view.dart';
import '../app/utils/constants.dart';
import '../domain/entities/enum/verify_method.dart';
import '../domain/entities/helper_center.dart';
import '../extension/string_extension.dart';
import '../domain/entities/member/member_center.dart';
import 'pages/auth/login/login_view.dart';
import 'pages/auth/password/forget_password_view.dart';
import 'pages/auth/password/otp_view.dart';
import 'pages/auth/password/reset_password_view.dart';
import 'pages/auth/register/register_view.dart';
import 'pages/static_view.dart';
import 'pages/helper_center/article/article_view.dart';
import 'pages/helper_center/bulletin/bulletin_view.dart';
import 'pages/helper_center/faq/faq_view.dart';
import 'pages/helper_center/helper_center_view.dart';
import 'pages/product/product_view.dart';
import 'pages/member/profile/member_profile_view.dart';
import 'pages/member/level/level_description_view.dart';
import 'pages/member/account_change/account_change_view.dart';
import 'pages/member/products/member_products_view.dart';
import 'pages/member/checkout_setting/invoice/invoice_setting_view.dart';
import 'pages/member/checkout_setting/checkout_setting_view.dart';
import 'pages/member/checkout_setting/shipping/shipping_infos_view.dart';

class MyPlusRouter {
  final LoginState loginState;

  MyPlusRouter(this.loginState);

  late final router = GoRouter(
    refreshListenable: loginState,
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      /// 根路徑
      GoRoute(
        name: rootRouteName,
        path: '/',
        redirect: (state) =>
            state.namedLocation(homeRouteName, params: {'tab': mainRouteName}),
      ),

      /// 登入頁
      GoRoute(
        name: loginRouteName,
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          fullscreenDialog: true,
          key: state.pageKey,
          child: LoginPage(),
        ),
      ),

      /// 忘記密碼
      GoRoute(
        name: forgetPasswordRouteName,
        path: '/forget-password',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ForgetPasswordPage(),
        ),
      ),

      /// 驗證簡訊驗證碼
      GoRoute(
        name: verifyMobileCodeRouteName,
        path: '/verify-mobile-code',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: OtpPage(
            state.queryParams['verifyType']?.toVerifyType ??
                VerifyType.verifyAccount,
            state.queryParams['mobile'] ?? '',
            mobileCode: state.queryParams['mobileCode'] ?? '',
          ),
        ),
      ),

      /// 修改密碼
      GoRoute(
        name: resetPasswordRouteName,
        path: '/reset-password',
        pageBuilder: (context, state) {
          String email = state.queryParams['email'] ?? '';
          String mobile = state.queryParams['mobile'] ?? '';
          return MaterialPage<void>(
            key: state.pageKey,
            child: ResetPasswordPage(
              email.isEmpty
                  ? (mobile.isEmpty
                      ? VerifyMethod.password
                      : VerifyMethod.mobile)
                  : VerifyMethod.email,
              mobileCode: state.queryParams['mobileCode'] ?? '',
              mobile: mobile,
              email: email,
            ),
          );
        },
      ),

      /// 註冊頁
      GoRoute(
        name: registerRouteName,
        path: '/register',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: RegisterPage(),
        ),
      ),

      /// 首頁
      GoRoute(
          name: homeRouteName,
          path: '/home/:tab(main|favorite|member|search)',
          pageBuilder: (context, state) {
            final tab = state.params['tab']!;
            return MaterialPage<void>(
              key: state.pageKey,
              child: MainPage(tab: tab),
            );
          },
          routes: [
            GoRoute(
              name: mainProductRouteName,
              path: 'product/:goods_no',
              pageBuilder: (context, state) {
                String? goodsNo = state.params[QueryKey.goodsNo];
                String? productId = state.params[QueryKey.productId];
                return MaterialPage<void>(
                  key: state.pageKey,
                  child: ProductPage(
                      goodsNo: goodsNo, productId: productId?.toInt()),
                );
              },
            ),
          ]),

      /// 幫助中心
      GoRoute(
        name: serviceRouteName,
        path: '/service',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const HelperCenterPage(),
        ),
      ),

      /// 常見問題
      GoRoute(
        name: faqRouteName,
        path: '/faq',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: FaqPage(),
        ),
      ),

      /// 服務公告
      GoRoute(
        name: bulletinRouteName,
        path: '/bulletin',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: BulletinPage(),
        ),
      ),

      /// 會員服務條款
      GoRoute(
        name: termsRouteName,
        path: '/terms',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ArticlePage(ArticleType.terms, title: '會員服務條款'),
        ),
      ),

      /// 隱私權條款
      GoRoute(
        name: privacyRouteName,
        path: '/privacy',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ArticlePage(ArticleType.privacy, title: '隱私權條款'),
        ),
      ),

      /// 關於我們
      GoRoute(
        name: aboutRouteName,
        path: '/about',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ArticlePage(ArticleType.about, title: '關於我們'),
        ),
      ),

      /// 買過商品
      GoRoute(
        name: boughtProductsRouteName,
        path: '/bought-products',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: MemberProductsPage(type: MemberProductsType.bought)),
      ),

      /// 瀏覽紀錄
      GoRoute(
        name: browseProductsRouteName,
        path: '/browse-products',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: MemberProductsPage(type: MemberProductsType.browse)),
      ),

      /// 會員資料
      GoRoute(
        name: memberProfileRouteName,
        path: '/member-profile',
        pageBuilder: (context, state) =>
            MaterialPage<void>(key: state.pageKey, child: MemberProfilePage()),
      ),

      /// 會員等級說明
      GoRoute(
        name: memberLevelInfoRouteName,
        path: '/member-level-info',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: LevelDescriptionPage(
                levelSettings: state.extra! as List<LevelSetting>)),
      ),

      /// 會員手機帳號變更
      GoRoute(
        name: mobileAccountChangeRouteName,
        path: '/mobile-acount-change',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: AccountChangePage(type: AccountType.mobile)),
      ),

      /// 會員信箱帳號變更
      GoRoute(
        name: emailAccountChangeRouteName,
        path: '/email-account-change',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: AccountChangePage(type: AccountType.email)),
      ),

      /// 結帳設定
      GoRoute(
        name: checkoutSettingRouteName,
        path: '/checkout-setting',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey, child: CheckoutSettingPage()),
      ),

      /// 發票設定
      GoRoute(
        name: invoiceSettingRouteName,
        path: '/invoice-setting',
        pageBuilder: (context, state) =>
            MaterialPage<void>(key: state.pageKey, child: InvoiceSettingPage()),
      ),

      /// 捐贈碼查詢網頁
      GoRoute(
        name: donationCodeWebRouteName,
        path: '/donation-code-web',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('捐贈碼查詢'),
            ),
            body: const WebView(
              initialUrl: 'https://www.einvoice.nat.gov.tw/APCONSUMER/BTC603W/',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ),
      ),

      /// 載具歸戶網頁
      GoRoute(
        name: carrierRegisterWebRouteName,
        path: '/carrier-register-web',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('財政部電子發票整合服務平台'),
            ),
            body: const WebView(
              initialUrl: 'https://www.einvoice.nat.gov.tw/',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ),
      ),

      /// 常用收件地址
      GoRoute(
        name: shippingAddressRouteName,
        path: '/shipping-address',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ShippingInfosPage(
            infos: state.extra as List<ShippingInfo>,
          ),
        ),
      ),

      // TODO(error): 靜態頁待實作
      GoRoute(
        name: staticRouteName,
        path: '/static',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: StaticPage(
              pageType: (state.extra ?? StaticPageType.error) as StaticPageType,
              title: state.queryParams['title'],
              message: state.queryParams['message'],
            ),
          );
        },
      ),

      // forwarding routes to remove the need to put the 'tab' param in the code
      GoRoute(
        path: '/main',
        redirect: (state) =>
            state.namedLocation(homeRouteName, params: {'tab': mainRouteName}),
      ),
      GoRoute(
        path: '/favorite',
        redirect: (state) => state
            .namedLocation(homeRouteName, params: {'tab': favoriteRouteName}),
      ),
      GoRoute(
        path: '/member',
        redirect: (state) => state
            .namedLocation(homeRouteName, params: {'tab': memberRouteName}),
      ),
      GoRoute(
        path: '/search',
        redirect: (state) => state
            .namedLocation(homeRouteName, params: {'tab': searchRouteName}),
      ),
      GoRoute(
          name: productRouteName,
          path: '/product-redirector/:goods_no',
          redirect: (state) {
            // TODO: error handling
            String goodsNo = state.params[QueryKey.goodsNo] ?? '';
            return state.namedLocation(mainProductRouteName, params: {
              'tab': mainRouteName,
              'goods_no': goodsNo,
            });
          }),
    ],

    /// 當有錯誤路徑時顯示錯誤頁
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: StaticPage(message: state.error.toString()),
    ),
/*
    /// 未登入的使用者進入特定頁面，需將它轉導至登入頁
    redirect: (state) {
      // 首頁
      final rootLoc = state.namedLocation(rootRouteName);

      // 登入
      final loginLoc = state.namedLocation(loginRouteName);
      final loggingIn = state.subloc == loginLoc;

      // 註冊
      final createAccountLoc = state.namedLocation(registerRouteName);
      final creatingAccount = state.subloc == createAccountLoc;
      
      // 登入狀態
      final loggedIn = loginState.loggedIn;

      if (!loggedIn && !loggingIn && !creatingAccount) return loginLoc;
      if (loggedIn && (loggingIn || creatingAccount)) return rootLoc;
      return null;
    },
    */
  );
}
