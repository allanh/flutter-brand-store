import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../drawer/my_plus_drawer_controller.dart';

class MyPlusDrawerHeader extends StatelessWidget {
  const MyPlusDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final controller =
        FlutterCleanArchitecture.getController<MyPlusDrawerController>(context);

    return GestureDetector(
      onTap: () => controller.loginIfNeeded(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90.0,
        decoration: BoxDecoration(
          color: theme.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.fill,
              child: IconButton(
                onPressed: () => controller.loginIfNeeded(),
                icon: Image.asset(
                  'assets/images/sidebar_login.png',
                  color: theme.appBarTheme.foregroundColor,
                ),
                iconSize: 55.0,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text('登入', style: theme.textTheme.headline6),
          ],
        ),
      ),
    );
  }
}
