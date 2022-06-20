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
    this.paddingStart = 0,
    this.paddingEnd = 0,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Focus(
          onFocusChange: widget.onFocusChange,
          child: TextFormField(
              controller: textController,
              onChanged: widget.onValueChange,
              keyboardType: TextInputType.text,
              obscureText: !passwordVisibility,
              decoration: InputDecoration(
                hintText: widget.hintText,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.lock, color: UdiColors.normalIcon, size: 20),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                suffixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 20, maxWidth: 20),
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    passwordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: UdiColors.normalIcon,
                    size: 20,
                  ),
                  onPressed: () => setState(() => passwordVisibility = !passwordVisibility),
                ),

                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                enabledBorder: _border(UdiColors.defaultBorder),
                focusedBorder: _border(UdiColors.focusedBorder),
                // 因錯誤訊息前需有圖示icon，故另外處理錯誤訊息，此處僅單純的變更輸入框線顏色
                errorText: widget.errorMessage != null ? '' : null,
                errorBorder: _border(UdiColors.danger),
                focusedErrorBorder: _border(UdiColors.danger),
                errorStyle: const TextStyle(height: 0, color: Colors.transparent),
              )),
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

  UnderlineInputBorder _border(Color color) =>
      UnderlineInputBorder(borderSide: BorderSide(color: color));

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
