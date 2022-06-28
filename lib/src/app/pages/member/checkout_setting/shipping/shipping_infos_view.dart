// ignore_for_file: must_be_immutable

import 'package:brandstores/src/domain/entities/member/shipping_info.dart';
import 'package:flutter/material.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../device/utils/my_plus_colors.dart';
import '../../../../widgets/member/dialog_wrapper.dart';
import '../../../../widgets/member/checkout_setting/reorderable_card.dart';
import '../../../../widgets/member/checkout_setting/shipping_info_view.dart';
import 'shipping_infos_controller.dart';

class ShippingInfosPage extends View {
  ShippingInfosPage({
    Key? key,
    required this.infos,
  }) : super(key: key);

  List<ShippingInfo> infos;

  @override
  _ShippingInfosPageState createState() => _ShippingInfosPageState();
}

class _ShippingInfosPageState
    extends ViewState<ShippingInfosPage, ShippingInfosController> {
  _ShippingInfosPageState()
      : super(
          ShippingInfosController(),
        );

  BuildContext? _context;

  /// 新增收件地址
  void handleAddShippingInfo() {}

  /// 編輯地址
  void handleEdit(ShippingInfo info) {
    debugPrint('Editing ${info.infoName}');
  }

  /// 刪除地址
  void handleDelete(ShippingInfo info) {
    DialogWrapper().showTwoButtonsDialog(
      context: context,
      content: '確定要刪除「${info.infoName}」？',
      contentPadding: const EdgeInsets.fromLTRB(30.0, 66.0, 30.0, 36.0),
      textAlign: TextAlign.center,
      handleCancel: () => Navigator.pop(context, '取消'),
      handleSubmit: () => Navigator.pop(context, '確定'),
    );
  }

  /// 排序收件地址
  void handleReorderInfos(int oldIndex, int newIndex) {
    setState(() {
      /// 調整 index 避免發生 out of bounds
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      /// 取出被拖移的地址
      ShippingInfo info = widget.infos.removeAt(oldIndex);

      /// 根據新的位置插入被拖移的地址
      widget.infos.insert(newIndex, info);
    });
  }

  ReorderableCard _buildShippingInfoCard(ShippingInfo info, index) =>
      ReorderableCard(
          key: ValueKey(index),
          item: ShippingInfoView(
            isDefault: index == 0,
            info: info,
            handleEdit: () => handleEdit(info),
            handleDelete: () => handleDelete(info),
          ),
          height: 185.0,
          isSelected: index == 0);

  @override
  Widget get view => ControlledWidgetBuilder<ShippingInfosController>(
        builder: (context, controller) {
          _context = context;

          final _addButton = Padding(
              padding: const EdgeInsets.all(12.0),
              child: OutlinedButton(
                onPressed: () => handleAddShippingInfo(),
                child: const Text('新增'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(width: 1, color: Colors.white),
                ),
              ));

          final _appBar = AppBar(
            title: const Text('常用收件地址'),
            actions: [_addButton],
          );

          final _message = Text(
            '已設定 ${widget.infos.length} 筆常用收件地址，最多可設定 15 筆。',
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: UdiColors.brownGrey),
          );

          final _headerIndicator = Text(
            '預設收件地址',
            style: Theme.of(context).textTheme.bodyLarge,
          );

          final _header = Builder(
            builder: (context) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12.0),
                _message,
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Container(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        height: 24.0,
                        width: 4.0),
                    const SizedBox(width: 6.0),
                    _headerIndicator,
                  ],
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          );

          /// 讓被拖移的地址卡片有效果
          Material _decorateDraggableCard(child, index, animation) => Material(
                child: Container(
                  transform: Matrix4.identity()..scale(1.01, 1.05),
                  child: ReorderableCard(
                    isSelected: true,
                    height: 185.0,
                    item: ShippingInfoView(
                      isDefault: index == 0,
                      info: widget.infos[index],
                      handleEdit: (idnex) => handleEdit(widget.infos[index]),
                      handleDelete: (index) =>
                          handleDelete(widget.infos[index]),
                    ),
                    isDragging: true,
                  ),
                ),
              );

          return Scaffold(
            appBar: _appBar,
            body: ReorderableListView.builder(
              itemCount: widget.infos.length,
              itemBuilder: (context, index) =>
                  _buildShippingInfoCard(widget.infos[index], index),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              header: _header,
              onReorder: (int oldIndex, int newIndex) =>
                  handleReorderInfos(oldIndex, newIndex),
              proxyDecorator: (child, index, animation) =>
                  _decorateDraggableCard(child, index, animation),
            ),
          );
        },
      );
}
