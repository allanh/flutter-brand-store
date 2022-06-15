import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'error_text.dart';

enum FieldType {
  underline,
  outline,
}

class UdiField extends StatefulWidget {
  const UdiField({
    Key? key,

    // listener
    this.onFocusChange,
    this.onValueChange,

    // value
    this.defaultValue,
    this.hintText,
    this.errorMessage,
    this.keyboardType = TextInputType.text,
    this.maxLength,

    // icon
    this.prefixIcon,
    this.suffixIcon,
    this.startIcon,
    this.endIcon,
    this.endIconOnPressed,

    // style
    this.fieldType = FieldType.underline,
    this.paddingStart = 0,
    this.paddingEnd = 0,
    this.errorPaddingHorizontal,
    this.enabled = true,
  }) : super(key: key);

  // listener
  final ValueChanged<bool>? onFocusChange;
  final Function(String)? onValueChange;

  // value
  final String? defaultValue;
  final String? hintText;
  final String? errorMessage;
  final TextInputType? keyboardType;
  final int? maxLength;

  // icon
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final IconData? startIcon;
  final IconData? endIcon;
  final VoidCallback? endIconOnPressed;

  // style
  final FieldType? fieldType;
  final double paddingStart;
  final double paddingEnd;
  final double? errorPaddingHorizontal;
  final bool enabled;

  @override
  State<UdiField> createState() => _UdiFieldState();
}

class _UdiFieldState extends State<UdiField> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.defaultValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Focus(
            onFocusChange: widget.onFocusChange,
            child: TextFormField(
                controller: textController,
                onChanged: widget.onValueChange,
                keyboardType: widget.keyboardType,
                inputFormatters: [LengthLimitingTextInputFormatter(widget.maxLength)],
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  isDense: true,
                  enabled: widget.enabled,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: widget.fieldType == FieldType.outline ? 10 : 0,
                  ),
                  prefixIcon: widget.startIcon != null
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(widget.fieldType == FieldType.outline ? 10 : 0, 0, 12, 0),
                          child: Icon(widget.startIcon, color: UdiColors.normalIcon, size: 20))
                      : widget.prefixIcon,
                  prefixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                  suffixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 20, maxWidth: 20),
                  suffixIcon: widget.endIcon != null
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(widget.endIcon, color: UdiColors.normalIcon, size: 20),
                          onPressed: widget.endIconOnPressed)
                      : widget.suffixIcon,

                  // 因錯誤訊息前需有圖示icon，故另外處理錯誤訊息，此處僅單純的變更輸入框線顏色
                  errorText: widget.errorMessage != null ? '' : null,
                  errorStyle: const TextStyle(height: 0, color: Colors.transparent),
                  errorBorder: _border(UdiColors.danger),
                  focusedErrorBorder: _border(UdiColors.danger),
                  enabledBorder: _border(UdiColors.defaultBorder),
                  focusedBorder: _border(UdiColors.focusedBorder),
                ))),
        const SizedBox(height: 4),
        ErrorText(
          widget.errorMessage,
          paddingStart: widget.errorPaddingHorizontal ?? widget.paddingStart,
          paddingEnd: widget.errorPaddingHorizontal ?? widget.paddingEnd,
        ),
      ],
    );
  }

  InputBorder _border(Color color) => widget.fieldType == FieldType.outline
      ? OutlineInputBorder(borderSide: BorderSide(color: color))
      : UnderlineInputBorder(borderSide: BorderSide(color: color));

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
