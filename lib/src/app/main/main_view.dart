import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';

import '../pages/test_entry_page.dart';
import '../utils/screen_config.dart';
import './main_controller.dart';
import '../../data/repositories/data_site_setting_repository.dart';
import '../drawer/my_plus_drawer_view.dart';
import '../pages/home/home_view.dart';
import '../pages/member_center/member_center_view.dart';
import '../../domain/entities/site_setting/layout_setting/sidebar.dart';
import '../utils/constants.dart';

class MainPage extends View {
  final int index;

  MainPage({Key? key, required String tab})
      : index = indexFrom(tab),
        super(key: key);

  @override
  _MainPageState createState() =>
      // inject dependencies inwards
      _MainPageState();

  static int indexFrom(String tab) {
    switch (tab) {
      case favoriteRouteName:
        return 1;
      case memberRouteName:
        return 2;
      case searchRouteName:
        // TODO: 分辨搜尋或更多
        return 3;
      default:
        return 0;
    }
  }
}

class _MainPageState extends ViewState<MainPage, MainController> {
  _MainPageState() : super(MainController(DataSiteSettingRepository()));

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedIndex = widget.index;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 1:
          context.go('/favorite');
          break;
        case 2:
          context.go('/member');
          break;
        case 3:
          context.go('/search');
          break;
        default:
          context.go('/main');
      }
    });
  }

  Widget _currentTitle(SidebarDirection direction) {
    switch (_selectedIndex) {
      case 0:
        return const Text('首頁');
      case 1:
        return const Text('我的收藏');
      case 2:
        return const Text('會員中心');
      case 3:
        return (direction == SidebarDirection.left)
            ? const Text('搜尋')
            : const Text('更多');
      default:
        return Container();
    }
  }

/*
  Widget _currentPage(SidebarDirection direction) {
    switch (_selectedIndex) {
      case 0:
        return HomePage(title: '首頁');
      case 1:
        return const TestPage();
      case 2:
        return MemberCenterPage(title: '會員中心');
      case 3:
        return (direction == SidebarDirection.left)
            ? HomePage(title: '搜尋')
            : HomePage(title: '更多');
      default:
        return Container();
    }
  }
*/
  IndexedStack _getTabPages(SidebarDirection direction) {
    List<Widget> pages = [
      HomePage(title: '首頁'),
      const TestPage(),
      MemberCenterPage(title: '會員中心'),
      (direction == SidebarDirection.left)
          ? HomePage(title: '搜尋')
          : HomePage(title: '更多')
    ];
    return IndexedStack(index: _selectedIndex, children: pages);
  }

  @override
  Widget get view {
    return ControlledWidgetBuilder<MainController>(
      builder: (context, controller) {
        SizeConfig().init(context);

        if (controller.siteSetting != null) {
          if (controller.siteSetting!.layout.sidebar.direction ==
              SidebarDirection.left) {
            return Scaffold(
              key: globalKey,
              appBar: AppBar(
                title: _currentTitle(SidebarDirection.left),
                elevation: 0,
                leading: Builder(builder: (context) {
                  return IconButton(
                      onPressed: () => {Scaffold.of(context).openDrawer()},
                      icon: Image.network(controller
                          .siteSetting!.layout.setting.logo.mobile2.uri));
                }),
              ),
              drawer: MyPlusDrawer(),
              //body: _currentPage(SidebarDirection.left),
              body: _getTabPages(SidebarDirection.left),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_outline_outlined),
                      label: '我的收藏'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: '會員中心'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: '搜尋'),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            );
          } else {
            return Scaffold(
              key: globalKey,
              appBar: AppBar(
                title: _currentTitle(SidebarDirection.right),
                actions: [Container()],
              ),
              endDrawer: MyPlusDrawer(),
              // body: _currentPage(SidebarDirection.right),
              body: _getTabPages(SidebarDirection.right),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat), label: '我的收藏'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle), label: '會員中心'),
                  BottomNavigationBarItem(icon: Icon(Icons.menu), label: '更多'),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            );
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
