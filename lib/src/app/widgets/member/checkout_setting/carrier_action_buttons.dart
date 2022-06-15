// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CarrierActionButtons extends StatefulWidget {
  CarrierActionButtons({
    Key? key,
    required this.handleReset,
    required this.handleSubmit,
  }) : super(key: key);

  Function handleReset;
  Function? handleSubmit;

  @override
  State<CarrierActionButtons> createState() => _CarrierActionButtonsState();
}

class _CarrierActionButtonsState extends State<CarrierActionButtons> {
  @override
  Widget build(BuildContext context) {
    Color _themeColor = Theme.of(context).appBarTheme.backgroundColor!;

    TextStyle _style =
        Theme.of(context).textTheme.caption!.copyWith(color: _themeColor);

    return SizedBox(
      height: 24.0,
      width: 173.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
              onPressed: () => widget.handleReset,
              child: Text(
                '清除資料',
                style: _style,
              )),
          ElevatedButton(
            onPressed:
                widget.handleSubmit != null ? () => widget.handleSubmit : null,
            child: const Text('儲存'),
          )
        ],
      ),
    );
  }
}
