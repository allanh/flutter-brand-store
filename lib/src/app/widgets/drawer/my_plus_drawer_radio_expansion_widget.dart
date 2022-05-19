
import 'package:brandstores/src/app/widgets/drawer/my_plus_drawer_expansion_tile_widget.dart';
// import 'package:brandstores/src/domain/entities/site_setting/event/event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/helper/index_path.dart';
import '../../../device/utils/my_plus_colors.dart';
import '../../../domain/entities/drawer_list_item.dart';
import '../../drawer/my_plus_drawer_controller.dart';
import 'my_plus_drawer_list_item_widget.dart';

class MyPlusDrawerRadioExpansion extends StatefulWidget {
  const MyPlusDrawerRadioExpansion({
    Key? key,
    required this.headerTitle,
    required this.items,
  }) : super(key: key);
  
  final String headerTitle;
  final List<DrawerListItem> items;
  @override
  State<MyPlusDrawerRadioExpansion> createState() => _MyPlusDrawerRadioExpansionState();
}

class _MyPlusDrawerRadioExpansionState extends State<MyPlusDrawerRadioExpansion> {
  IndexPath selectedIndexPath = IndexPath(-1, -1, -1);
  // IndexPath categorySelectedIndexPath = IndexPath(-1, -1, -1);

  _onExpansion(bool expanding, IndexPath indexPath, int level) {
    if (expanding) {
      setState(() {
        const Duration(seconds: 2000);
        selectedIndexPath = indexPath;
      });
    } else {
      setState(() {
        selectedIndexPath = (level == 0)
            ? IndexPath(-1, -1, -1)
            : IndexPath(selectedIndexPath.section,
                selectedIndexPath.row, -1);
      });
    }
  }

  Widget _buildHeader(BuildContext context) {
    // final theme = Theme.of(context);
    return Container(
      height: 33.0,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10.0),
      decoration: const BoxDecoration(
        color: UdiColors.white2,
      ),
      child: Text(widget.headerTitle),
    );
  }
  Widget _buildItem(DrawerListItem item,  IndexPath indexPath, int level, MyPlusDrawerController controller, bool lastItem) {
    if (item.children.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyPlusDrawerListItem(
            title: Text(
              item.title, 
              // style: Theme.of(context).textTheme.bodyText2?.copyWith(color: UdiColors.greyishBrown, fontWeight: FontWeight.normal),
            ),
            onTap: () => { controller.onTap(item.link)},
            expanded: false,
            lastItem: lastItem
          ),
          // (index == lastIndex-1) ? Container() : const Divider(),
        ],
      );
    }
    final expanded = selectedIndexPath == indexPath ||
        indexPath == IndexPath(selectedIndexPath.section, -1, -1) ||
        indexPath ==
            IndexPath(selectedIndexPath.section,
                selectedIndexPath.row, -1);
    return MyPlusDrawerExpansionTile(
      key: Key(indexPath.toString()),
      initiallyExpanded: expanded,
      title: Text(
        item.title,
      ),
      childrenPadding: const EdgeInsets.only(left: 10),
      onExpansionChanged: (bool expanding) =>
          _onExpansion(expanding, indexPath, level+1),
      lastItem: lastItem,
      children: item.children
          .asMap()
          .entries
          .map((e) => _buildItem(
            e.value, 
            (level == 0)
                ? IndexPath(indexPath.section, e.key, 0)
                : IndexPath(indexPath.section, indexPath.row, e.key),
                level+1,
                controller, 
                e.key == item.children.length-1))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = FlutterCleanArchitecture.getController<MyPlusDrawerController>(context);

    return ListView.builder(
      key: Key('builder ${selectedIndexPath.toString()}'),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildHeader(context);
        }
        index -= 1;
        return _buildItem(widget.items[index], IndexPath(index, -1, -1), 0, controller, index == widget.items.length-1);
      });
  }

}