// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';

abstract class DefaultCarrierInterface {
  late bool isDefault;
}

class ReorderableCard extends StatefulWidget {
  ReorderableCard({
    Key? key,
    required this.item,
    required this.height,
    required this.isSelected,
    this.isEditing = false,
    this.isDragging = false,
  }) : super(key: key);

  late double height;

  late bool isSelected;

  late Widget item;

  bool? isEditing;

  bool? isDragging;

  @override
  State<ReorderableCard> createState() => _ReorderableCardState();
}

class _ReorderableCardState extends State<ReorderableCard> {
  final Radius _radiusValue = const Radius.circular(4.0);
  final double _sortIndicatorHeight = 30.0;
  @override
  Widget build(BuildContext context) {
    Color _selectedColor = widget.isSelected
        ? Theme.of(context).appBarTheme.backgroundColor!
        : UdiColors.veryLightGrey2;

    RoundedRectangleBorder _roundedRectangleBorder = RoundedRectangleBorder(
        side: BorderSide(
          color: _selectedColor,
          width: widget.isSelected ? 2.0 : 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0));

    Container _dragIndicator = Container(
      width: 44.0,
      decoration: BoxDecoration(
        color: _selectedColor,
        borderRadius: BorderRadius.only(
            topRight: _radiusValue, bottomRight: _radiusValue),
      ),
      child: const Center(
        child: Icon(
          Icons.drag_handle,
          color: Colors.white,
        ),
      ),
    );

    Widget sortIndicator = SizedBox(
      height: _sortIndicatorHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: UdiColors.brownGrey2,
                height: 1,
              ),
            ),
            const SizedBox(
              width: 30.0,
              child: Image(
                image: AssetImage('assets/images/icon_other_filter_sort.png'),
              ),
            ),
            Expanded(
                child: Container(
              color: UdiColors.brownGrey2,
              height: 1,
            )),
          ],
        ),
      ),
    );

    List<Widget> children = [
      SizedBox(
        height: widget.height,
        child: Card(
          elevation: 3.0,
          shape: _roundedRectangleBorder,
          child: Row(children: [
            Expanded(child: widget.item),
            _dragIndicator,
          ]),
        ),
      ),
    ];

    if (widget.isSelected && widget.isDragging == false) {
      children.insert(1, sortIndicator);
    }
    double height = widget.isSelected && widget.isDragging == false
        ? widget.height + _sortIndicatorHeight
        : widget.height;
    return Padding(
      padding: widget.isSelected
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        height: height,
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
