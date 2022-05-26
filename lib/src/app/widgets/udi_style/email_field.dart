import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

import 'error_text.dart';

class EmailField extends StatefulWidget {
  const EmailField({
    Key? key,
    this.defaultValue,
    this.onFocusChange,
    this.onValueChange,
    this.errorMessage,
    this.paddingStart = 16,
    this.paddingEnd = 16,
  }) : super(key: key);
  final String? defaultValue;
  final ValueChanged<bool>? onFocusChange;
  final Function(String)? onValueChange;
  final String? errorMessage;
  final double paddingStart;
  final double paddingEnd;

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
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
            onChanged: widget.onValueChange,
            keyboardType: TextInputType.emailAddress,
            controller: textController,
            decoration: _inputDecoration(
              prefixIcon: Icons.email,
              hintText: '請輸入Email',
              showErrorBolder: widget.errorMessage != null,
            ),
          ),
        ),
        const SizedBox(height: 4),
        ErrorText(
          widget.errorMessage,
          paddingStart: widget.paddingStart,
          paddingEnd: widget.paddingEnd,
        ),
      ],
    );
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
