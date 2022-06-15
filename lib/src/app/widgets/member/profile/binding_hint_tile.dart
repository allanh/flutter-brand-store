import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';

/// 建立帳號綁定提示
class BindingHintTile extends StatelessWidget {
  const BindingHintTile({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: SizedBox(
            width: double.infinity,
            height: 75.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 30.0,
                    child: Row(
                      children: [
                        /// 「綁定帳號」文字右邊的線條
                        Container(
                          height: 20.0,
                          width: 2.0,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                        const SizedBox(width: 9.0),
                        Text('綁定帳號',
                            style: TextStyle(
                                color: UdiColors.greyishBrown,
                                fontFamily: 'PingFangTC Semibold',
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0))
                      ],
                    )),
                const SizedBox(width: 9.0),
                SizedBox(
                    height: 24.0,
                    child: Text('綁定帳號後，下次可使用這些帳號快速登入。',
                        style: TextStyle(
                            color: UdiColors.brownGrey,
                            fontFamily: 'PingFangTC Regular',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0)))
              ],
            )));
  }
}
