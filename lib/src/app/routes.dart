import 'package:brandstores/src/app/pages/member/checkout_setting/shipping/shipping_info_detail_view.dart';
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
import 'pages/product/product_controller.dart';
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
import 'widgets/product/base_product_dialog.dart';
import 'widgets/product/choose_spec/product_dialog_spec_widget.dart';
import 'widgets/product/full_image/full_screen_image_slider_widget.dart';

class MyPlusRouter {
  final LoginState loginState;

  MyPlusRouter(this.loginState);

  late final router = GoRouter(
    refreshListenable: loginState,
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      /// ?????????
      GoRoute(
        name: rootRouteName,
        path: '/',
        redirect: (state) =>
            state.namedLocation(homeRouteName, params: {'tab': mainRouteName}),
      ),

      /// ?????????
      GoRoute(
        name: loginRouteName,
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          fullscreenDialog: true,
          key: state.pageKey,
          child: LoginPage(),
        ),
      ),

      /// ????????????
      GoRoute(
        name: forgetPasswordRouteName,
        path: '/forget-password',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ForgetPasswordPage(),
        ),
      ),

      /// ?????????????????????
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

      /// ????????????
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

      /// ?????????
      GoRoute(
        name: registerRouteName,
        path: '/register',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: RegisterPage(),
        ),
      ),

      /// ??????
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
          routes: []),

      /// ????????????
      GoRoute(
        name: serviceRouteName,
        path: '/service',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const HelperCenterPage(),
        ),
      ),

      /// ????????????
      GoRoute(
        name: faqRouteName,
        path: '/faq',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: FaqPage(),
        ),
      ),

      /// ????????????
      GoRoute(
        name: bulletinRouteName,
        path: '/bulletin',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: BulletinPage(),
        ),
      ),

      /// ??????????????????
      GoRoute(
        name: termsRouteName,
        path: '/terms',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ArticlePage(ArticleType.terms, title: '??????????????????'),
        ),
      ),

      /// ???????????????
      GoRoute(
        name: privacyRouteName,
        path: '/privacy',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ArticlePage(ArticleType.privacy, title: '???????????????'),
        ),
      ),

      /// ????????????
      GoRoute(
        name: aboutRouteName,
        path: '/about',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ArticlePage(ArticleType.about, title: '????????????'),
        ),
      ),

      /// ????????????
      GoRoute(
        name: boughtProductsRouteName,
        path: '/bought-products',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: MemberProductsPage(type: MemberProductsType.bought)),
      ),

      /// ????????????
      GoRoute(
        name: browseProductsRouteName,
        path: '/browse-products',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: MemberProductsPage(type: MemberProductsType.browse)),
      ),

      /// ????????????
      GoRoute(
        name: memberProfileRouteName,
        path: '/member-profile',
        pageBuilder: (context, state) =>
            MaterialPage<void>(key: state.pageKey, child: MemberProfilePage()),
      ),

      /// ??????????????????
      GoRoute(
        name: memberLevelInfoRouteName,
        path: '/member-level-info',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: LevelDescriptionPage(
                levelSettings: state.extra! as List<LevelSetting>)),
      ),

      /// ????????????????????????
      GoRoute(
        name: mobileAccountChangeRouteName,
        path: '/mobile-acount-change',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: AccountChangePage(type: AccountType.mobile)),
      ),

      /// ????????????????????????
      GoRoute(
        name: emailAccountChangeRouteName,
        path: '/email-account-change',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: AccountChangePage(type: AccountType.email)),
      ),

      /// ????????????
      GoRoute(
        name: checkoutSettingRouteName,
        path: '/checkout-setting',
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey, child: CheckoutSettingPage()),
      ),

      /// ????????????
      GoRoute(
        name: invoiceSettingRouteName,
        path: '/invoice-setting',
        pageBuilder: (context, state) =>
            MaterialPage<void>(key: state.pageKey, child: InvoiceSettingPage()),
      ),

      /// ?????????????????????
      GoRoute(
        name: donationCodeWebRouteName,
        path: '/donation-code-web',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('???????????????'),
            ),
            body: const WebView(
              initialUrl: 'https://www.einvoice.nat.gov.tw/APCONSUMER/BTC603W/',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ),
      ),

      /// ??????????????????
      GoRoute(
        name: carrierRegisterWebRouteName,
        path: '/carrier-register-web',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('???????????????????????????????????????'),
            ),
            body: const WebView(
              initialUrl: 'https://www.einvoice.nat.gov.tw/',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ),
      ),

      /// ??????????????????
      GoRoute(
        name: shippingInfosRouteName,
        path: '/$shippingInfosRouteName',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ShippingInfosPage(
            infos: state.extra as List<ShippingInfo>,
          ),
        ),
      ),

      /// ????????????????????????
      GoRoute(
        name: shippingInfoDetailRouteName,
        path: '/$shippingInfoDetailRouteName',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: state.extra != null
              ? ShippingInfoDetailPage(info: state.extra as ShippingInfo)
              : ShippingInfoDetailPage(info: null),
        ),
      ),

      // TODO(error): ??????????????????
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
        path: '/product/:goods_no',
        pageBuilder: (context, state) {
          String? goodsNo = state.params[QueryKey.goodsNo];
          String? productId = state.params[QueryKey.productId];
          return MaterialPage<void>(
            key: state.pageKey,
            child: ProductPage(goodsNo: goodsNo, productId: productId?.toInt()),
          );
        },
        routes: <GoRoute>[
          GoRoute(
            name: productImageRouteName,
            path: 'image/:index',
            pageBuilder: (context, state) {
              int? index = state.params[QueryKey.index]?.toInt();
              final Map<String, Object> params =
                  state.extra! as Map<String, Object>;
              final List<String> imagePaths =
                  params[QueryKey.imagePaths]! as List<String>;
              return MaterialPage<void>(
                  key: state.pageKey,
                  child: FullScreenImageSliderWidget(
                    imagePaths: imagePaths,
                    currentIndex: index,
                  ));
            },
          ),

          // ?????????
          GoRoute(
            name: specName,
            path: 'spec',
            pageBuilder: (context, state) {
              final Map<String, Object?> params =
                  state.extra! as Map<String, Object?>;
              // ???????????? controller,
              if (params.containsKey(QueryKey.productController)) {
                final controller =
                    params[QueryKey.productController] as ProductController;

                return MaterialPage<void>(
                    key: state.pageKey,
                    child: BaseProductDialogWidget(
                      // ?????????
                      child: ProductSpecWidget(
                        product: controller.product!,
                        initParams: controller.selectedSpecParams,
                        specChoosed: (params) =>
                            controller.handleSpecChoosed(params),
                        favoriteTapped: () => controller.handlefavoriteTapped(),
                        addToCartTapped: () =>
                            controller.handleAddToCartTapped(),
                      ),
                    ));
              } else {
                return MaterialPage<void>(
                    key: state.pageKey, child: StaticPage());
              }
            },
          ),
        ],
      ),
    ],

    /// ????????????????????????????????????
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: StaticPage(message: state.error.toString()),
    ),
/*
    /// ?????????????????????????????????????????????????????????????????????
    redirect: (state) {
      // ??????
      final rootLoc = state.namedLocation(rootRouteName);

      // ??????
      final loginLoc = state.namedLocation(loginRouteName);
      final loggingIn = state.subloc == loginLoc;

      // ??????
      final createAccountLoc = state.namedLocation(registerRouteName);
      final creatingAccount = state.subloc == createAccountLoc;
      
      // ????????????
      final loggedIn = loginState.loggedIn;

      if (!loggedIn && !loggingIn && !creatingAccount) return loginLoc;
      if (loggedIn && (loggingIn || creatingAccount)) return rootLoc;
      return null;
    },
    */
  );
}
