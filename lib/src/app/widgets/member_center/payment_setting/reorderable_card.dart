// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';

abstract class DefaultCarrierInterface {
  late bool isDefault;
}

class ReorderableCard extends StatefulWidget {
  late double height;

  late bool isSelected;

  late Widget item;

  ReorderableCard({
    Key? key,
    required this.item,
    required this.height,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<ReorderableCard> createState() => _ReorderableCardState();
}

class _ReorderableCardState extends State<ReorderableCard> {
  final Radius _radiusValue = const Radius.circular(4.0);

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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
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
    );
  }
}
