import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

class UdiTabBar extends StatefulWidget {
  const UdiTabBar(this.tabNames, {Key? key, this.onTap, this.tabType = TabType.basicTab}) : super(key: key);
  final List<String> tabNames;
  final ValueChanged<int>? onTap;
  final TabType tabType;

  @override
  State<UdiTabBar> createState() => _UdiTabBarState();
}

class _UdiTabBarState extends State<UdiTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.tabNames.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      labelColor: UdiColors.secondaryText,
      labelStyle: const TextStyle(fontSize: 18),
      unselectedLabelColor: UdiColors.secondaryText,
      indicator: const BoxDecoration(
        border: Border(bottom: BorderSide(color: UdiColors.secondaryText, width: 2)),
      ),
      onTap: widget.onTap,
      tabs: widget.tabNames.map((name) => Tab(text: name)).toList(),
    );
  }
}

enum TabType {
  basicTab,
}
