import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';

abstract class DefaultCarrierInterface {
  late bool isDefault;
}

class CarrierCard extends StatefulWidget {
  // @override
  late double height;

  // @override
  late bool isSelected;

  // @override
  late Widget item;

  CarrierCard({
    Key? key,
    required this.item,
    required this.height,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<CarrierCard> createState() => _CarrierCardState();
}

class _CarrierCardState extends State<CarrierCard> {
  final Radius _radiusValue = const Radius.circular(4.0);
  @override
  Widget build(BuildContext context) {
    RoundedRectangleBorder roundedRectangleBorder = RoundedRectangleBorder(
        side: BorderSide(
          color: widget.isSelected
              ? Theme.of(context).appBarTheme.backgroundColor!
              : UdiColors.veryLightGrey2,
          width: widget.isSelected ? 2.0 : 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0));
    Container drag = Container(
      width: 44.0,
      decoration: BoxDecoration(
          color: widget.isSelected
              ? Theme.of(context).appBarTheme.backgroundColor!
              : UdiColors.veryLightGrey2,
          borderRadius: BorderRadius.only(
              topRight: _radiusValue, bottomRight: _radiusValue)),
      child: const Center(
        child: Icon(Icons.drag_handle, color: Colors.white),
      ),
    );
    return SizedBox(
      height: widget.height,
      child: Card(
        shape: roundedRectangleBorder,
        child: Row(children: [
          Expanded(child: widget.item),
          drag,
        ]),
      ),
    );
  }
}
