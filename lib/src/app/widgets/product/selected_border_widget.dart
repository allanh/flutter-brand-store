import 'package:flutter/material.dart';

/// 選取時的框線
class SelectedBorderWidget extends StatelessWidget {
  const SelectedBorderWidget(
      {Key? key, required this.isSelected, this.radius = 2.0})
      : super(key: key);

  final double radius;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Color _primaryColor = Theme.of(context).primaryColor;

    return Stack(children: [
      Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          border: Border.all(width: isSelected ? 2 : 0, color: _primaryColor),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      // 右下角的勾勾
      if (isSelected)
        Positioned(
            bottom: 0,
            right: 0,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(_primaryColor, BlendMode.srcATop),
              child:
                  Image.asset('assets/images/icon_for_all_check_triangle.png'),
            ))
    ]);
  }
}
