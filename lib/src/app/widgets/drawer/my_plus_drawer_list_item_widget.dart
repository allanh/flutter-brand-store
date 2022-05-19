import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

class MyPlusDrawerListItem extends StatelessWidget {

  const MyPlusDrawerListItem({
    Key? key,
    required this.title, 
    this.trailing,
    this.onTap,
    required this.expanded,
    required this.lastItem,
  }) : super(key: key);

  final Function()? onTap;
  final Widget title;
  final Widget? trailing;
  final bool expanded;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.bodyText2!.copyWith(color: (expanded) ? theme.primaryColor : UdiColors.greyishBrown, fontWeight: FontWeight.normal);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 44.0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(21.0, 12.0, 21.0, 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedDefaultTextStyle(
                    style: titleStyle,
                    duration: kThemeChangeDuration,
                    child: title,
                  ),
                  trailing ?? Container(),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0),
          child: (!lastItem) ? const Divider(height: 1.0,) : Container()
        ),
      ],
    );
  }
}