import 'package:brandstores/src/app/widgets/drawer/my_plus_drawer_radio_expansion_widget.dart';
import 'package:brandstores/src/data/repositories/member/data_member_center_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'my_plus_drawer_controller.dart';
import '../../data/repositories/data_drawer_info_repository.dart';
import '../../domain/entities/site_setting/menu_setting/menu_setting.dart';

import '../widgets/drawer/my_plus_drawer_info_widget.dart';
import '../widgets/drawer/my_plus_drawer_header_widget.dart';
import '../widgets//drawer/my_plus_drawer_hotkey_widget.dart';

class _MyPlusDrawerState
    extends ViewState<MyPlusDrawer, MyPlusDrawerController> {
  _MyPlusDrawerState()
      : super(MyPlusDrawerController(DataDrawerInfoRepository(), DataMemberCenterRepository()));


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
                  return MyPlusDrawerHotKey(hotKeys: hotKeys);
                case 'footer':
                  return MyPlusDrawerRadioExpansion(headerTitle: '商店資訊', items: footer);
                case 'news':
                  return MyPlusDrawerRadioExpansion(headerTitle: '最新活動', items: eventList.items);
                case 'menu':
                return MyPlusDrawerRadioExpansion(headerTitle: '導覽選單', items: header);
                case 'category':
                  return MyPlusDrawerRadioExpansion(headerTitle: '商品分類', items: sidebar.items);
                case 'info':
                  return MyPlusDrawerInfo(
                      enabled: sections.contains('footer'), basic:basic);
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
