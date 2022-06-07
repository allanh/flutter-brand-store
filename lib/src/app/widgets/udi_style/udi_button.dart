import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

class UdiButton extends StatelessWidget {
  const UdiButton({
    Key? key,
    this.text = '',
    this.onPressed,
    this.buttonType = ButtonType.basicButton,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(text, style: const TextStyle(fontSize: 18)),
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
        primary: isEnable ? Colors.white : UdiColors.disabledText,
        backgroundColor: isEnable ? Theme.of(context).primaryColor : UdiColors.white2,
        side: isEnable ? null : const BorderSide(color: UdiColors.defaultBorder),
      );

  ButtonStyle _secondaryButtonStyle(BuildContext context, bool isEnable) =>
      OutlinedButton.styleFrom(
        primary: isEnable ? Theme.of(context).primaryColor : UdiColors.disabledText,
        backgroundColor: isEnable ? Colors.transparent : UdiColors.white2,
        side: BorderSide(color: isEnable ? UdiColors.border : UdiColors.defaultBorder),
      );
}

enum ButtonType {
  basicButton,
  secondaryButton,
}
