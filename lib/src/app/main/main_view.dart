import './main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../data/repositories/data_site_setting_resposotory.dart';
import '../../domain/entities/site_setting.dart';
import '../pages/home/home_view.dart';

class MainPage extends View {
  MainPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MainPagetate createState() =>
      // inject dependencies inwards
      _MainPagetate();

}
class _MainPagetate extends ViewState<MainPage, MainController> {
  _MainPagetate() : super(MainController(DataSiteSettingRepository()));

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        return (direction == SidebarDirection.left) ? const Text('搜尋') : const Text('更多');
      default:
        return Container();
    }
  }

  Widget _currentPage(SidebarDirection direction) {
    switch (_selectedIndex) {
      case 0: 
        return HomePage(title: '首頁');
      case 1:
        return HomePage(title: '我的收藏');
      case 2:
        return HomePage(title: '會員中心');
      case 3:
        return (direction == SidebarDirection.left) ? HomePage(title: '搜尋') : HomePage(title: '更多');
      default:
        return Container();
    }
  }

  @override
  Widget get view {
    return ControlledWidgetBuilder<MainController>(
      builder: (context, controller) {
        if (controller.siteSetting != null) {
          if (SiteSetting.current.layout.sidebar.direction == SidebarDirection.left) {
            return Scaffold(
              appBar: AppBar(
                title: _currentTitle(SidebarDirection.left),
                backgroundColor: ThemeColor.navagationBackground,
                foregroundColor: ThemeColor.navigationTint,
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: ()=> {
                        Scaffold.of(context).openDrawer()
                      }, 
                      icon: Image.network(controller.siteSetting!.layout.setting.logo.mobile2.uri)
                    );
                  }),
              ),
              drawer: const Drawer(),
              body: _currentPage(SidebarDirection.left),
              bottomNavigationBar: BottomNavigationBar(items: 
                const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_outlined), label: '我的收藏'),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: '會員中心'),
                  BottomNavigationBarItem(icon: Icon(Icons.search), label: '搜尋'),
                ],
                selectedItemColor: ThemeColor.bottomBarTint,
                unselectedItemColor: ThemeColor.bottomBarTint.withAlpha(192),
                backgroundColor: ThemeColor.bottomBarBackground,
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: ThemeColor.navagationBackground,
                foregroundColor: ThemeColor.navigationTint,
                title: _currentTitle(SidebarDirection.right),
                actions: [
                  Container()
                ],
              ),
              endDrawer: const Drawer(),
              body: _currentPage(SidebarDirection.right),
              bottomNavigationBar: BottomNavigationBar(items: 
                const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
                  BottomNavigationBarItem(icon: Icon(Icons.chat), label: '我的收藏'),
                  BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '會員中心'),
                  BottomNavigationBarItem(icon: Icon(Icons.menu), label: '更多'),
                ],
                selectedItemColor: ThemeColor.bottomBarTint,
                unselectedItemColor: ThemeColor.bottomBarTint.withAlpha(192),
                backgroundColor: ThemeColor.bottomBarBackground,
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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title ?? 'Test'),
    //   ),
    //   body: Scaffold(
    //     key:
    //         globalKey, // built in global key for the ViewState for easy access in the controller
    //     body: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           ControlledWidgetBuilder<MainController>(
    //             builder: (context, controller) {
    //               return Text(
    //                 controller.siteSetting == null ? '' : '${controller.siteSetting}',
    //                 style: Theme.of(context).textTheme.headline4,
    //               );
    //             },
    //           ),
    //           ControlledWidgetBuilder<MainController>(
    //             builder: (context, controller) {
    //               return ElevatedButton(
    //                 onPressed: controller.getSiteSetting,
    //                 child: const Text(
    //                   'Get User',
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               );
    //             },
    //           ),
    //           ControlledWidgetBuilder<MainController>(
    //             builder: (context, controller) {
    //               return ElevatedButton(
    //                 onPressed: controller.getUserwithError,
    //                 child: const Text(
    //                   'Get User Error',
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   floatingActionButton: ControlledWidgetBuilder<MainController>(
    //     builder: (context, controller) {
    //       return FloatingActionButton(
    //         onPressed: () => controller.buttonPressed(),
    //         tooltip: 'Increment',
    //         child: const Icon(Icons.add),
    //       );
    //     },
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "首頁"),
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.favorite_outline_outlined), label: "我的收藏"),
    //       BottomNavigationBarItem(icon: Icon(Icons.person), label: "會員中心"),
    //       BottomNavigationBarItem(icon: Icon(Icons.search), label: "搜尋"),
    //     ],
    //     type: BottomNavigationBarType.fixed,
    //     currentIndex: _selectedIndex,
    //     onTap: _onItemTapped,
    //   ),
    // );
  }
}
