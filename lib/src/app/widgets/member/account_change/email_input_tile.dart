import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';

class EmailInputTile extends StatelessWidget {
  const EmailInputTile({
    Key? key,
    required this.handleEmailChange,
    required this.isValid,
  }) : super(key: key);

  final void Function(String) handleEmailChange;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
        borderSide: BorderSide(
            color: isValid ? UdiColors.veryLightGrey2 : UdiColors.strawberry));
    return Padding(
      padding: const EdgeInsets.only(top: 42.0, left: 24.0, right: 24.0),
      child: TextField(
        onChanged: (text) => handleEmailChange(text),
        cursorColor: UdiColors.brownGrey2,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: '請輸入Email',
          hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                color: UdiColors.brownGrey2,
                fontSize: 16.0,
              ),
          border: _underlineInputBorder,
          enabledBorder: _underlineInputBorder,
          focusedBorder: _underlineInputBorder,
          prefixIcon: const Icon(
            Icons.email,
            color: UdiColors.brownGrey,
          ),
        ),
      ),
    );
  }
}
