import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:provider/provider.dart';

import '../../drawer/my_plus_drawer_controller.dart';
import '../../../../../login_state.dart';

class MyPlusDrawerHeader extends StatelessWidget {
  const MyPlusDrawerHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final controller =
        FlutterCleanArchitecture.getController<MyPlusDrawerController>(context);
    final bool isLogin = Provider.of<LoginState>(context, listen: false).loggedIn;
    return GestureDetector(
      onTap: () => (isLogin) ? null : controller.login(),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 90.0,
          decoration: BoxDecoration(
            color: theme.primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(33.0, 18.0, 0.0, 17.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                      'assets/images/sidebar_login.png',
                      color: theme.appBarTheme.foregroundColor,
                      width: 55.0,
                      height: 55.0,
                    ),
                ),
                const SizedBox(
                  width: 10,
                ),
                (isLogin) ? Text(title ?? '', style: theme.textTheme.headline6) : Text('登入/註冊', style: theme.textTheme.headline6),
              ],
            ),
          ),
        ),
    );
  }
}
