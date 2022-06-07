import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'error_text.dart';

class MobileField extends StatefulWidget {
  const MobileField({
    Key? key,
    this.defaultValue,
    this.onFocusChange,
    this.onValueChange,
    this.errorMessage,
    this.paddingStart = 0,
    this.paddingEnd = 0,
  }) : super(key: key);
  final String? defaultValue;
  final ValueChanged<bool>? onFocusChange;
  final Function(String)? onValueChange;
  final String? errorMessage;
  final double paddingStart;
  final double paddingEnd;

  @override
  State<MobileField> createState() => _MobileFieldState();
}

class _MobileFieldState extends State<MobileField> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.defaultValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              child: const Text('+886', style: TextStyle(fontSize: 16)),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: UdiColors.defaultBorder, width: 2)),
              )),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
            children: [
              Focus(
                onFocusChange: widget.onFocusChange,
                child: TextFormField(
                  onChanged: widget.onValueChange,
                  controller: textController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: _inputDecoration(
                    hintText: '請輸入手機號碼',
                    showErrorBolder: widget.errorMessage != null,
                  ),
                ),
              ),
              ErrorText(
                widget.errorMessage,
                paddingStart: widget.paddingStart,
                paddingEnd: widget.paddingEnd,
              ),
            ],
          ))
        ]);
  }

  // 輸入框底線 (因錯誤訊息前需有圖示icon，故另外處理錯誤訊息，此處僅單純的變更輸入框線顏色)
  InputDecoration _inputDecoration({
    String? hintText,
    bool showErrorBolder = false,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) =>
      InputDecoration(
          prefixIcon: prefixIcon == null ? null : Icon(prefixIcon, color: UdiColors.normalIcon),
          hintText: hintText,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          errorText: showErrorBolder ? '' : null,
          errorBorder: _border(UdiColors.danger),
          focusedBorder: _border(UdiColors.focusedBorder),
          border: _border(UdiColors.defaultBorder),
          errorStyle: const TextStyle(height: 0, color: Colors.transparent),
          suffixIcon: suffixIcon);

  UnderlineInputBorder _border(Color color) =>
      UnderlineInputBorder(borderSide: BorderSide(color: color));

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
