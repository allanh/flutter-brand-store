import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:brandstores/src/app/widgets/product/dialog/product_dialog_title_widget.dart';
import 'package:flutter/material.dart';

class BaseProductDialogWidget extends StatelessWidget {
  final String? title;
  final Widget child;

  const BaseProductDialogWidget({
    Key? key,
    required this.child,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Container(
        padding: EdgeInsets.only(top: SizeConfig.statusBarHeight),
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          // 標題列
          if (title?.isNotEmpty == true)
            ProductDialogTitleWidget(title: title!),

          // child layout
          SizedBox(
            width: SizeConfig.screenWidth,
            child: child,
          ),
        ]),
      ));
}
