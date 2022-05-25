import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';

/// 建立儲存按鈕
class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.context,
    required this.handleSave,
  }) : super(key: key);

  final BuildContext context;
  final void Function() handleSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
        child: SizedBox(
            width: double.infinity,
            height: 36.0,
            child: ElevatedButton(
                child: const Text('儲存'),
                onPressed: handleSave,
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).appBarTheme.backgroundColor,
                    textStyle: const TextStyle(
                        color: UdiColors.white,
                        fontFamily: 'PingFangTC Semibold',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0)))));
  }
}
