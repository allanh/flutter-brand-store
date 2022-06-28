import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../device/utils/my_plus_colors.dart';
import '../../../utils/constants.dart';

class CarrierRegisterDialog extends StatelessWidget {
  const CarrierRegisterDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Container(
        color: UdiColors.veryLightGrey2,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                    child: Center(
                        child: Text('發票歸戶作業',
                            style: Theme.of(context).textTheme.bodyText1))),
                SizedBox(
                  width: 20.0,
                  child: CloseButton(
                    onPressed: () => Navigator.pop(context, '取消'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      contentPadding: const EdgeInsets.fromLTRB(24.0, 26.0, 24.0, 10.0),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      content: Text(
          '即將前往「財政部電子發票整合服務平台」，完成歸戶後，將由「財政部電子發票整合服務平台」進行發票兌獎、領獎通知及相關作業；品牌商店名稱不另行通知與寄送中獎發票。',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.caption),
      actions: <Widget>[
        SizedBox(
          width: 110.0,
          height: 36.0,
          child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 1.0,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context, '取消'),
                child: const Text('取消'),
                style: OutlinedButton.styleFrom(
                    primary: Theme.of(context).appBarTheme.backgroundColor),
              )),
        ),
        SizedBox(
          width: 110.0,
          height: 36.0,
          child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 1.0,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, '確定');
                    context.pushNamed(carrierRegisterWebRouteName);
                  },
                  child: const Text('確定'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).appBarTheme.backgroundColor,
                  ))),
        ),
      ],
    );
  }
}
