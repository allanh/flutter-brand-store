import 'package:flutter/material.dart';

class SelectedBorder extends StatelessWidget {
  const SelectedBorder({Key? key, required this.isSelected}) : super(key: key);

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Color _primaryColor = Theme.of(context).primaryColor;

    return Container(
        decoration: BoxDecoration(
          //color: _primaryColor,
          border: Border.all(width: isSelected ? 2 : 0, color: _primaryColor),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: isSelected
            ? Align(
                alignment: Alignment.bottomRight,
                child: ColorFiltered(
                  colorFilter:
                      ColorFilter.mode(_primaryColor, BlendMode.srcATop),
                  child: Image.asset(
                      'assets/images/icon_for_all_check_triangle.png'),
                ))
            : const SizedBox.shrink());
  }
}
