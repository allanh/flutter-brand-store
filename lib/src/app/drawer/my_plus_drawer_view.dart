import 'package:brandstores/src/data/repositories/data_member_center_repository.dart';
import 'package:brandstores/src/domain/entities/site_setting/event/event_list.dart';
import 'package:brandstores/src/domain/entities/site_setting/store_setting/basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'my_plus_drawer_controller.dart';
import '../../data/repositories/data_drawer_info_repository.dart';
import '../../domain/entities/site_setting/layout_setting/sidebar.dart';
import '../../domain/entities/site_setting/menu_setting/menu_setting.dart';
import '../../device/utils/my_plus_colors.dart';
import '../../data/helper/index_path.dart';

import '../widgets/drawer/my_plus_drawer_header_widget.dart';

class _MyPlusDrawerState
    extends ViewState<MyPlusDrawer, MyPlusDrawerController> {
  _MyPlusDrawerState()
      : super(MyPlusDrawerController(DataDrawerInfoRepository(), DataMemberCenterRepository()));

  // event
  Widget _buildEventItems(EventListItem item, int index) {
    return ListTile(title: Text(item.title));
  }

  Widget _buildEvent(BuildContext context, EventList eventList) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: eventList.items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0 && eventList.listTitle != null) {
            return _buildHeader(context, eventList.listTitle!.title);
          }
          index -= 1;
          return _buildEventItems(eventList.items[index], index);
        });
  }

  // category
  IndexPath categorySelectedIndexPath = IndexPath(-1, -1, -1);
  _onExpansion(bool expanding, IndexPath indexPath, int level) {
    if (expanding) {
      setState(() {
        const Duration(seconds: 2000);
        categorySelectedIndexPath = indexPath;
      });
    } else {
      setState(() {
        categorySelectedIndexPath = (level == 0)
            ? IndexPath(-1, -1, -1)
            : IndexPath(categorySelectedIndexPath.section,
                categorySelectedIndexPath.row, -1);
      });
    }
  }

  Widget _buildCategoryItem(SidebarItem item, IndexPath indexPath, int level) {
    if (item.children.isEmpty) return ListTile(title: Text(item.title));
    final expanded = categorySelectedIndexPath == indexPath ||
        indexPath == IndexPath(categorySelectedIndexPath.section, -1, -1) ||
        indexPath ==
            IndexPath(categorySelectedIndexPath.section,
                categorySelectedIndexPath.row, -1);
    return ExpansionTile(
      key: Key(indexPath.toString()),
      initiallyExpanded: expanded,
      title: Text(
        item.title,
      ),
      childrenPadding: const EdgeInsets.only(left: 10),
      onExpansionChanged: (bool expanding) =>
          _onExpansion(expanding, indexPath, level + 1),
      children: item.children
          .asMap()
          .entries
          .map((e) => _buildCategoryItem(
              e.value,
              (level == 0)
                  ? IndexPath(indexPath.section, e.key, 0)
                  : IndexPath(indexPath.section, indexPath.row, e.key),
              level + 1))
          .toList(),
    );
  }

  Widget _buildCategory(BuildContext context, Sidebar sidebar) {
    return ListView.builder(
        key: Key('builder ${categorySelectedIndexPath.toString()}'),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: sidebar.items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader(context, '商品分類');
          }
          index -= 1;
          return _buildCategoryItem(
              sidebar.items[index], IndexPath(index, -1, -1), 0);
        });
  }

  // hot key
  List<Widget> _buildRemainingHotKeysItems(
      BuildContext context, List<MenuSettingItem> hotKeys) {
    List<MenuSettingItem> remaining = List.from(hotKeys);
    remaining.removeRange(0, 2);
    return remaining.map<Widget>((MenuSettingItem item) {
      return TextButton(
          onPressed: () => {debugPrint(item.title)}, child: Text(item.title));
    }).toList();
  }

  Widget _buildHotKeys(BuildContext context, List<MenuSettingItem> hotKeys) {
    if (hotKeys.isEmpty) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildHotKeysItems(context, hotKeys),
    );
  }

  List<Widget> _buildHotKeysItems(
      BuildContext context, List<MenuSettingItem> hotKeys) {
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
              onPressed: () => {},
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
                    onPressed: () => {},
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

  //
  Widget _buildHeader(BuildContext context, String title) {
    // final theme = Theme.of(context);
    return Container(
      height: 33.0,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10.0),
      decoration: const BoxDecoration(
        color: UdiColors.white2,
      ),
      child: Text(title),
    );
  }

  // footer
  int footerSeelctedIndex = -1;
  _onFooterExpansion(
    bool expanding,
    int index,
  ) {
    if (expanding) {
      setState(() {
        const Duration(seconds: 0);
        footerSeelctedIndex = index;
      });
    } else {
      setState(() {
        footerSeelctedIndex = -1;
      });
    }
  }

  Widget _buildFooterItem(MenuSettingItem item, int index) {
    if (item.children.isEmpty) return ListTile(title: Text(item.title));
    final expanded = footerSeelctedIndex == index;
    return ExpansionTile(
      key: Key(index.toString()),
      initiallyExpanded: expanded,
      title: Text(
        item.title,
      ),
      childrenPadding: const EdgeInsets.only(left: 10),
      onExpansionChanged: (bool expanding) =>
          _onFooterExpansion(expanding, index),
      children: item.children
          .asMap()
          .entries
          .map((e) => _buildFooterItem(e.value, e.key))
          .toList(),
    );
  }

  Widget _buildFooter(BuildContext context, List<MenuSettingItem> footers) {
    return ListView.builder(
        key: Key('builder ${footerSeelctedIndex.toString()}'),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: footers.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader(context, '商店資訊');
          }
          index -= 1;
          return _buildFooterItem(footers[index], index);
        });
  }

  // menu
  int menuSeelctedIndex = -1;
  _onMenuExpansion(
    bool expanding,
    int index,
  ) {
    if (expanding) {
      setState(() {
        const Duration(seconds: 0);
        menuSeelctedIndex = index;
      });
    } else {
      setState(() {
        menuSeelctedIndex = -1;
      });
    }
  }

  Widget _buildMenuItem(MenuSettingItem item, int index) {
    if (item.children.isEmpty) return ListTile(title: Text(item.title));
    final expanded = footerSeelctedIndex == index;
    return ExpansionTile(
      key: Key(index.toString()),
      initiallyExpanded: expanded,
      title: Text(
        item.title,
      ),
      childrenPadding: const EdgeInsets.only(left: 10),
      onExpansionChanged: (bool expanding) =>
          _onMenuExpansion(expanding, index),
      children: item.children
          .asMap()
          .entries
          .map((e) => _buildMenuItem(e.value, e.key))
          .toList(),
    );
  }

  Widget _buildMenu(BuildContext context, List<MenuSettingItem> footers) {
    return ListView.builder(
        key: Key('builder ${menuSeelctedIndex.toString()}'),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: footers.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader(context, '商店資訊');
          }
          index -= 1;
          return _buildMenuItem(footers[index], index);
        });
  }

  List<Widget> _storeInfo(ThemeData theme, Basic basic) {
    return [
      Text(basic.name, style: theme.textTheme.caption),
      Text(basic.store.phone, style: theme.textTheme.caption),
      Text(basic.email, style: theme.textTheme.caption),
      Text(basic.store.businessHour, style: theme.textTheme.caption),
      Text(basic.store.address.toString(), style: theme.textTheme.caption),
      Text('© 2020-2021  ${basic.name} 版權所有', style: theme.textTheme.caption),
    ];
  }

  // info
  Widget _buildInfo(ThemeData theme, bool enabled, Basic basic) {
    final theme = Theme.of(context);
    return Container(
        decoration: BoxDecoration(
          color: theme.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (enabled)
                ? _storeInfo(theme, basic)
                : [
                    Text('© 2020-2021  ${basic.name} 版權所有',
                        style: theme.textTheme.caption)
                  ],
          ),
        ));
  }

  // sections
  List<String> _buildSections(
      List<MenuSettingItem> hotKeys, List<MenuSettingSwitchItem> switchs) {
    List<String> _sections = ['header'];
    if (hotKeys.isNotEmpty) _sections.add('hot_key');
    for (var element in switchs) {
      _sections.add(element.type.toString().split('.').last);
    }
    _sections.add('info');
    return _sections;
  }

  @override
  Widget get view {
    return ControlledWidgetBuilder<MyPlusDrawerController>(
        builder: (context, controller) {
      final theme = Theme.of(context);
      if (controller.siteSetting != null) {
        final sidebar = controller.siteSetting!.layout.sidebar;
        final hotKeys = controller.siteSetting!.menu.hotKeys;
        final footer = controller.siteSetting!.menu.footers;
        final header = controller.siteSetting!.menu.headers;
        List<MenuSettingSwitchItem> switchs = List.from(controller
            .siteSetting!.menu.switchs
            .where((element) => element.enabled));
        final eventList = controller.siteSetting!.eventList;
        final basic = controller.siteSetting!.store.basic;
        final sections = _buildSections(hotKeys, switchs);
        return Drawer(
          child: ListView.builder(
              key: globalKey,
              itemCount: sections.length,
              itemBuilder: (context, index) {
                final element = sections[index];
                switch (element) {
                  case 'header':
                    return MyPlusDrawerHeader(title: controller.memberCenter?.member?.name);
                  case 'hot_key':
                    return _buildHotKeys(context, hotKeys);
                  case 'footer':
                    return _buildFooter(context, footer);
                  case 'news':
                    return _buildEvent(context, eventList);
                  case 'menu':
                    return _buildMenu(context, header);
                  case 'category':
                    return _buildCategory(context, sidebar);
                  case 'info':
                    return _buildInfo(
                        theme, sections.contains('footer'), basic);
                  default:
                    return Container();
                }
              },
            ),
          );
      }
      return Container();
    });
  }
}

class MyPlusDrawer extends View {
  MyPlusDrawer({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyPlusDrawerState createState() =>
      // inject dependencies inwards
      _MyPlusDrawerState();
}
