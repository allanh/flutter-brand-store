import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';

class PasswordInputTile extends StatefulWidget {
  const PasswordInputTile({Key? key, required this.handlePasswordChange})
      : super(key: key);

  final void Function(String) handlePasswordChange;

  @override
  State<PasswordInputTile> createState() => _PasswordInputTileState();
}

class _PasswordInputTileState extends State<PasswordInputTile> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder _underlineInputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: UdiColors.veryLightGrey2),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 42.0, left: 24.0, right: 24.0),
      child: TextField(
        onChanged: (text) => widget.handlePasswordChange(text),
        obscureText: visible == false,
        cursorColor: UdiColors.brownGrey2,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: '請輸入6-20碼英數字',
          hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                color: UdiColors.brownGrey2,
                fontSize: 16.0,
              ),
          border: _underlineInputBorder,
          enabledBorder: _underlineInputBorder,
          focusedBorder: _underlineInputBorder,
          prefixIcon: const Icon(
            Icons.lock,
            color: UdiColors.brownGrey,
          ),
          suffixIcon: IconButton(
              onPressed: () => setState(() => visible = !visible),
              icon: Icon(
                visible ? Icons.remove_red_eye_sharp : Icons.visibility_off,
                color: UdiColors.brownGrey,
              )),
        ),
      ),
    );
  }
}
