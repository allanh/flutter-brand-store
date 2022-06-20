import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';

class MobileInputTile extends StatefulWidget {
  const MobileInputTile({Key? key, required this.handleMobileChange})
      : super(key: key);

  final void Function(String) handleMobileChange;

  @override
  State<MobileInputTile> createState() => _MobileInputTileState();
}

class _MobileInputTileState extends State<MobileInputTile> {
  @override
  Widget build(BuildContext context) {
    const UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: UdiColors.veryLightGrey2),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 42.0, left: 24.0, right: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 50.0,
            child: TextField(
              maxLength: 3,
              cursorColor: UdiColors.brownGrey2,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                counterText: '',
                hintText: '+886',
                border: _underlineInputBorder,
                enabledBorder: _underlineInputBorder,
                focusedBorder: _underlineInputBorder,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          SizedBox(
            width:
                MediaQuery.of(context).size.width - 24.0 - 24.0 - 16.0 - 50.0,
            child: TextField(
              maxLength: 10,
              onChanged: (text) => widget.handleMobileChange(text),
              cursorColor: UdiColors.brownGrey2,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                counterText: '',
                hintText: '請輸入手機號碼',
                hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 16.0,
                      color: UdiColors.brownGrey2,
                    ),
                border: _underlineInputBorder,
                enabledBorder: _underlineInputBorder,
                focusedBorder: _underlineInputBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
