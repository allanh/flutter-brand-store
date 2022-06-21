import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 標題列
class ProductDialogTitleWidget extends StatelessWidget {
  // 標題
  final String? title;

  const ProductDialogTitleWidget({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: SizeConfig.screenWidth,
        height: 42,
        decoration: const BoxDecoration(color: UdiColors.white2),
        child: Stack(
          children: [
            // 標題
            Align(
                child: Text(title ?? '',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 16, color: UdiColors.greyishBrown))),
            // 關閉鍵
            Positioned(
                right: 0,
                child: InkWell(
                  onTap: () => context.pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset('assets/images/icon_close_20px.png'),
                  ),
                ))
          ],
        ),
      );
}
