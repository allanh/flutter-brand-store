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
              child: const Text('+886',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: UdiColors.normalText,
                  )),
              padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: UdiColors.defaultBorder, width: 1)),
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
                    hintText: '?????????????????????',
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

  // ??????????????? (??????????????????????????????icon???????????????????????????????????????????????????????????????????????????)
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
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          errorText: showErrorBolder ? '' : null,
          errorBorder: _border(UdiColors.danger),
          focusedErrorBorder: _border(UdiColors.danger),
          focusedBorder: _border(UdiColors.focusedBorder),
          enabledBorder: _border(UdiColors.defaultBorder),
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
