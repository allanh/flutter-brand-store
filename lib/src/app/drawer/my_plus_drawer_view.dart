import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './my_plus_drawer_controller.dart';
import '../../data/repositories/data_drawer_info_repository.dart';
import '../../domain/entities/site_setting/site_setting.dart';
import '../../domain/entities/site_setting/layout_setting/sidebar.dart';
import '../../domain/entities/site_setting/menu_setting/menu_setting.dart';

class _MyPlusDrawerState extends ViewState<MyPlusDrawer, MyPlusDrawerController> {
  _MyPlusDrawerState() : super(MyPlusDrawerController(DataDrawerInfoRepository()));

  int selected = 0;

  _onExpansion(MyPlusDrawerController controller, bool expanding, int index, ) {
    if (expanding) {
      setState(() {
        const Duration(seconds: 0);
        selected = index;
    });
    } else {
      setState(() {
        selected = -1;
      });
    }
  }
  Widget _buildDrawerHeader(BuildContext context, ThemeData theme, Sidebar sidebar) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 90,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: sidebar.logoBackground,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fill,
                  child: IconButton(
                      onPressed: ()=>{
                        // check if user already login in
                      }, icon: Image.asset('assets/images/sidebar_login.png', color: sidebar.logoTint,),
                      iconSize: 55.0,),
                ),
                const SizedBox(width: 10,),
                Text('登入', style: theme.textTheme.headline6),
              ],
            )
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildHotKeysItems(context, SiteSetting.current.menu.hotKeys, sidebar),
          // children: [
          //   SizedBox(
          //     width: MediaQuery.of(context).size.width,
          //     height: 44,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children:[
          //         Text(hotkeys[0].title),
          //         Text(hotkeys[1].title),
          //       ] 
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsetsDirectional.only(start: 14),
          //     child: Text(hotkeys[2].title),),
          // ],
        )
      ],
    ); 
  }

  Widget _buildMenuItem(MyPlusDrawerController controller, SidebarItem item, int index) {
    if (item.children.isEmpty) return ListTile(title: Text(item.title));
    final expanded = selected == index;
    return ExpansionTile(
      key: Key(index.toString()),
      initiallyExpanded: expanded,
      title: Text(
        item.title,
      ),
      childrenPadding: const EdgeInsets.only(left: 10),
      onExpansionChanged: (bool expanding)=> _onExpansion(controller, expanding, index),
      // collapsedIconColor: Colors.amberAccent,
      // iconColor: Colors.amber,
      // collapsedTextColor: Colors.blueAccent,
      // textColor: Colors.blue,
      children: item.children.asMap().entries.map((e) => _buildMenuItem(controller, e.value, e.key)).toList(),
    );
  }
  List<Widget> _buildRemainingHotKeysItems(BuildContext context, List<MenuSettingItem> hotKeys, Sidebar sidebar) {
    List<MenuSettingItem> remaining = List.from(hotKeys);
    remaining.removeRange(0, 2);
    return remaining.map<Widget>((MenuSettingItem item) {
      return TextButton(onPressed: ()=> {
        // ignore: avoid_print
        print(item.title)
      }, child: Text(item.title));
    }).toList();
  }
  List<Widget> _buildHotKeysItems(BuildContext context, List<MenuSettingItem> hotKeys, Sidebar sidebar) {
    if (hotKeys.isEmpty) return [];
    List<Widget> _widgets = [];
    final width = MediaQuery.of(context).size.width*3.0/8.0;
    _widgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: width,
            height: 44,
            child: TextButton(onPressed: ()=> {

            }, child: Text(hotKeys[0].title),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(sidebar.logoBackground)),
            ),
          ),
          (hotKeys.length > 1) 
          ? SizedBox(
            width: width,
            height: 44,
            child: TextButton(onPressed: ()=> {

            }, child: Text(hotKeys[1].title),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(sidebar.logoBackground)),
            ),
          )
          : Container(), 
        ],
      )
    );
    if (hotKeys.length > 2) {
      _widgets.addAll(_buildRemainingHotKeysItems(context, hotKeys, sidebar));
    }
    // return hotKeys.map<Widget>((MenuSettingItem item) {
    //   return TextButton(onPressed: ()=> {
    //     // ignore: avoid_print
    //     print(item.title)
    //   }, child: Text(item.title));
    // }).toList();
    return _widgets;
  }

  @override
  Widget get view {
    return ControlledWidgetBuilder<MyPlusDrawerController>(
      builder: (context, controller) {
        final theme = Theme.of(context);
        final sidebar = SiteSetting.current.layout.sidebar;
        return Drawer(
          child: ListView.builder(
            key: Key('builder ${selected.toString()}'),
            itemCount: sidebar.items.length,

            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildDrawerHeader(context, theme, sidebar); 
              }
              index -= 1;
              return _buildMenuItem(controller, SiteSetting.current.layout.sidebar.items[index], index);
            }
          )
        );
      });


    // return Drawer(
    //   child: ListView.builder(
    //     key: Key('builder ${selected.toString()}'),
    //     itemCount: sidebar.items.length,
    //     itemBuilder: (context, index) {
    //       if (index == 0) {
    //         return Column(
    //           children: [
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width,
    //               height: 90,
    //               child: DrawerHeader(
    //                 decoration: BoxDecoration(
    //                   color: sidebar.logoBackground,
    //                 ),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     FittedBox(
    //                       fit: BoxFit.fill,
    //                       child: IconButton(
    //                           onPressed: ()=>{
    //                             // check if user already login in
    //                           }, icon: const Icon(Icons.alarm),//Image.asset('assets/images/sidebar_login.png', color: sidebar.logoTint,),
    //                           iconSize: 55.0,),
    //                     ),
    //                     const SizedBox(width: 10,),
    //                     Text('登入', style: theme.textTheme.headline6),
    //                   ],
    //                 )
    //               ),
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: _buildHotKeysItems(SiteSetting.current.menu.hotKeys),
    //               // children: [
    //               //   SizedBox(
    //               //     width: MediaQuery.of(context).size.width,
    //               //     height: 44,
    //               //     child: Row(
    //               //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               //       children:[
    //               //         Text(hotkeys[0].title),
    //               //         Text(hotkeys[1].title),
    //               //       ] 
    //               //     ),
    //               //   ),
    //               //   Padding(
    //               //     padding: const EdgeInsetsDirectional.only(start: 14),
    //               //     child: Text(hotkeys[2].title),),
    //               // ],
    //             )
    //           ],
    //         ); 
            
    //       }
    //       index -= 1;
    //       return _buildMenuItem(SiteSetting.current.layout.sidebar.items[index], index);
    //     }
    //   )
    // );
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
