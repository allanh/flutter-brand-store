import 'package:brandstores/src/app/utils/screen_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../device/utils/my_plus_colors.dart';
import '../../pages/product/product_controller.dart';

// 選單類型
enum ProductMenuType { home, member, history, like, search, share }

// 選單類型的圖片
extension ProductMenuTypeExtension on ProductMenuType {
  String get icon {
    switch (this) {
      case ProductMenuType.home:
        return 'assets/images/icon_home_28px.png';
      case ProductMenuType.member:
        return 'assets/images/icon_member_28px.png';
      case ProductMenuType.history:
        return 'assets/images/icon_history_28px.png';
      case ProductMenuType.like:
        return 'assets/images/icon_like_28px.png';
      case ProductMenuType.search:
        return 'assets/images/icon_search_28px.png';
      case ProductMenuType.share:
        return 'assets/images/icon_share_28px.png';
    }
  }
}

/// 商品頁 AppBar
class ProductAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  ProductAppBarWidget(
      {Key? key,
      required this.controller,
      required this.tabs,
      this.showTabBar = false,
      this.onTabBarTap})
      : preferredSize = Size.fromHeight(showTabBar
            ? kToolbarHeight + 60 * SizeConfig.screenRatio
            : kToolbarHeight),
        super(key: key);

  final ProductController controller;
  // TabBar 字串
  final List<String> tabs;
  // 是否顯示 TabBar
  final bool showTabBar;
  // TabBar 點擊事件
  final ValueChanged<int>? onTabBarTap;

  @override
  final Size preferredSize;

  @override
  State<StatefulWidget> createState() => _ProductAppBarWidgetState();
}

class _ProductAppBarWidgetState extends State<ProductAppBarWidget> {
  var appBarHeight = AppBar().preferredSize.height;
  // Tabbar
  TabBar get _tabBar => TabBar(
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: UdiColors.brownGrey,
        tabs: widget.tabs.map((String name) => Tab(text: name)).toList(),
        onTap: (int index) {
          if (widget.onTabBarTap != null) {
            widget.onTabBarTap!(index);
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      // 關閉商品頁，回前一頁
      leading: InkWell(
        onTap: () => context.pop(),
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: const Text('商品'),
      centerTitle: true,
      backgroundColor: Colors.black,
      actions: [
        // 購物車
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
        // 更多動作
        PopupMenuButton(
          onSelected: (value) {
            _onMenuItemSelected(value as int);
          },
          offset: Offset(0.0, appBarHeight),
          color: Colors.black.withOpacity(0.5),
          constraints: const BoxConstraints(maxWidth: 34),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          // 選單項目
          itemBuilder: (ctx) => [
            _buildPopupMenuItem(ProductMenuType.home),
            _buildPopupMenuItem(ProductMenuType.member),
            _buildPopupMenuItem(ProductMenuType.history),
            _buildPopupMenuItem(ProductMenuType.like),
            _buildPopupMenuItem(ProductMenuType.search),
            _buildPopupMenuItem(ProductMenuType.share),
          ],
        )
      ],

      // Tabbar列
      bottom: widget.showTabBar == true
          ? PreferredSize(
              preferredSize: Size.fromHeight(40 * SizeConfig.screenRatio),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: 1.0,
                child: ColoredBox(
                  color: Colors.white,
                  // TabBar
                  child: _tabBar,
                ),
              ))
          : null,
    );
  }

  /// 建立 MenuItem
  PopupMenuItem _buildPopupMenuItem(ProductMenuType type) {
    return PopupMenuItem(
        value: type.index,
        height: 28,
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Center(
            child: Image.asset(
          type.icon,
          color: Colors.white,
        )));
  }

  // 選單選擇事件
  _onMenuItemSelected(int value) {
    if (value == ProductMenuType.member.index) {
    } else if (value == ProductMenuType.history.index) {
    } else if (value == ProductMenuType.like.index) {
    } else if (value == ProductMenuType.search.index) {
    } else if (value == ProductMenuType.share.index) {
    } else {}
  }
}
