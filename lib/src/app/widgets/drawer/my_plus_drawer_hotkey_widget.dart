import 'package:brandstores/src/app/drawer/my_plus_drawer_controller.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/site_setting/menu_setting/menu_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MyPlusDrawerHotKey extends StatelessWidget {
  const MyPlusDrawerHotKey({
    Key? key,
    required this.hotKeys,
  }) : super(key: key);

  final List<MenuSettingItem> hotKeys;

  List<Widget> _buildRemainingHotKeysItems(
      BuildContext context, List<MenuSettingItem> hotKeys) {
    final controller =
    FlutterCleanArchitecture.getController<MyPlusDrawerController>(context);
    List<MenuSettingItem> remaining = List.from(hotKeys);
    remaining.removeRange(0, 2);
    return remaining.map<Widget>((MenuSettingItem item) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 44.0,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.title,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: UdiColors.greyishBrown),
                ),
              ),
              onPressed: () => controller.onTap(item.link),
            ),
          ),
          (item == remaining.last) ? Container() : const Divider(),
        ],
      );
    }).toList();
  }

  List<Widget> _buildHotKeysItems(
      BuildContext context, List<MenuSettingItem> hotKeys) {
    final controller =
    FlutterCleanArchitecture.getController<MyPlusDrawerController>(context);

    if (hotKeys.isEmpty) return [];
    final theme = Theme.of(context);
    List<Widget> _widgets = [];
    final width = (MediaQuery.of(context).size.width - 8.0) * 3.0 / 8.0;
    _widgets.add(Padding(
      padding: const EdgeInsets.fromLTRB(9.0, 12.0, 9.0, 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width,
            height: 44,
            child: TextButton(
              onPressed: () => controller.onTap(hotKeys[0].link),
              child: Text(hotKeys[0].title),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all(theme.textTheme.headline6!.color),
                backgroundColor: MaterialStateProperty.all(
                    theme.appBarTheme.backgroundColor),
              ),
            ),
          ),
          (hotKeys.length > 1)
              ? SizedBox(
                  width: width,
                  height: 44,
                  child: TextButton(
                    onPressed: () => controller.onTap(hotKeys[1].link),
                    child: Text(hotKeys[1].title),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            theme.textTheme.headline6!.color),
                        backgroundColor: MaterialStateProperty.all(
                            theme.appBarTheme.backgroundColor)),
                  ),
                )
              : Container(),
        ],
      ),
    ));
    if (hotKeys.length > 2) {
      _widgets.addAll(_buildRemainingHotKeysItems(context, hotKeys));
    }
    return _widgets;
  }

  @override
  Widget build(BuildContext context) {
    if (hotKeys.isEmpty) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildHotKeysItems(context, hotKeys),
    );
  }
}