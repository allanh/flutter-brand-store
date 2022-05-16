import 'package:brandstores/src/app/pages/product/product_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../login_state.dart';
import '../app/utils/constants.dart';
import '../app/main/main_view.dart';
import 'pages/error/error_view.dart';
import 'pages/auth/login/login_view.dart';
import 'pages/auth/register/register_view.dart';
import '../extension/string_extension.dart';

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
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),

      /// 註冊頁
      GoRoute(
        name: registerRouteName,
        path: '/register',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const RegisterPage(),
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

      // TODO(error): 靜態頁待實作
      GoRoute(
        name: staticRouteName,
        path: '/static',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ErrorPage(),
        ),
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
      child: ErrorPage(error: state.error),
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
