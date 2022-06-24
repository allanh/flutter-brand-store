import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

class UdiButton extends StatelessWidget {
  const UdiButton({
    Key? key,
    this.text = '',
    this.onPressed,
    this.buttonType = ButtonType.basicButton,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    this.radius = 4.0,
    this.opacity = 1.0,
    this.fontSize = 18,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final ButtonType buttonType;
  final EdgeInsets padding;
  final double radius; // 圓角
  final double opacity; // 透明度
  final double fontSize; // 文字大小

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Padding(
        padding: padding,
        child: Text(text),
      ),
      style: _getStyle(context, onPressed != null),
    );
  }

  ButtonStyle _getStyle(BuildContext context, bool isEnable) {
    switch (buttonType) {
      case ButtonType.secondaryButton:
        return _secondaryButtonStyle(context, isEnable);
      case ButtonType.basicButton:
      default:
        return _basicButtonStyle(context, isEnable);
    }
  }

  ButtonStyle _basicButtonStyle(BuildContext context, bool isEnable) => OutlinedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: fontSize,
          color: isEnable ? Colors.white : UdiColors.disabledText,
          fontWeight: FontWeight.bold,
        ),
        primary: isEnable ? Colors.white : UdiColors.disabledText,
        backgroundColor: isEnable ? Theme.of(context).primaryColor.withOpacity(opacity) : UdiColors.white2,
        side: isEnable ? null : const BorderSide(color: UdiColors.defaultBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      );

  ButtonStyle _secondaryButtonStyle(BuildContext context, bool isEnable) => OutlinedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: fontSize,
          color: isEnable ? Theme.of(context).primaryColor : UdiColors.disabledText,
          fontWeight: FontWeight.bold,
        ),
        primary: isEnable ? Theme.of(context).primaryColor : UdiColors.disabledText,
        backgroundColor: isEnable ? Colors.transparent : UdiColors.white2,
        side: BorderSide(color: isEnable ? UdiColors.border : UdiColors.defaultBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      );
}

enum ButtonType {
  basicButton,
  secondaryButton,
}
