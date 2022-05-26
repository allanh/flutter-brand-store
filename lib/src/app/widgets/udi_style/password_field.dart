import 'package:brandstores/src/app/widgets/udi_style/error_text.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    this.onValueChange,
    this.onFocusChange,
    this.hintText = '請輸入密碼',
    this.errorMessage,
    this.paddingStart = 16,
    this.paddingEnd = 16,
  }) : super(key: key);
  final ValueChanged<bool>? onFocusChange;
  final Function(String)? onValueChange;
  final String? hintText;
  final String? errorMessage;
  final double paddingStart;
  final double paddingEnd;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final textController = TextEditingController();

  bool passwordVisibility = false;
  VoidCallback? suffixIconPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Focus(
          onFocusChange: widget.onFocusChange,
          child: TextFormField(
              onChanged: widget.onValueChange,
              keyboardType: TextInputType.text,
              controller: textController,
              obscureText: !passwordVisibility,
              decoration: _inputDecoration(
                  hintText: widget.hintText,
                  showErrorBolder: widget.errorMessage != null,
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisibility ? Icons.visibility : Icons.visibility_off,
                        color: UdiColors.normalIcon,
                      ),
                      onPressed: () => setState(() => passwordVisibility = !passwordVisibility)))),
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
