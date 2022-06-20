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
            decoration: InputDecoration(
                hintText: '請輸入Email',
                prefixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.email, color: UdiColors.normalIcon, size: 20),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                errorText: widget.errorMessage != null ? '' : null,
                errorBorder: _border(UdiColors.danger),
                focusedBorder: _border(UdiColors.focusedBorder),
                enabledBorder: _border(UdiColors.defaultBorder),
                errorStyle: const TextStyle(height: 0, color: Colors.transparent)),
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

  UnderlineInputBorder _border(Color color) =>
      UnderlineInputBorder(borderSide: BorderSide(color: color));

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
