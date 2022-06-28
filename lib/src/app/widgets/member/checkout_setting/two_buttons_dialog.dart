// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';

class TwoButtonsDialog extends StatelessWidget {
  TwoButtonsDialog({
    Key? key,
    this.title,
    required this.content,
    required this.contentPadding,
    required this.textAlign,
    required this.handleCancel,
    required this.handleSubmit,
  }) : super(key: key);

  String? title;
  String content;
  EdgeInsets contentPadding;
  TextAlign textAlign;
  Function handleCancel;
  Function handleSubmit;

  @override
  Widget build(BuildContext context) {
    var _titleBar = title != null
        ? Container(
            color: UdiColors.veryLightGrey2,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Center(
                            child: Text(title!,
                                style: Theme.of(context).textTheme.bodyText1))),
                    SizedBox(
                      width: 20.0,
                      child: CloseButton(
                        onPressed: () => Navigator.pop(context, '取消'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : null;

    const _actionsPadding =
        EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0);

    var _cancelButton = SizedBox(
      width: 110.0,
      height: 36.0,
      child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 1.0,
          child: OutlinedButton(
            onPressed: () => handleCancel(),
            child: const Text('取消'),
            style: OutlinedButton.styleFrom(
                primary: Theme.of(context).appBarTheme.backgroundColor),
          )),
    );

    var _doneButton = SizedBox(
      width: 110.0,
      height: 36.0,
      child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 1.0,
          child: ElevatedButton(
              onPressed: () => handleSubmit(),
              child: const Text('確定'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).appBarTheme.backgroundColor,
              ))),
    );

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: _titleBar,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      contentPadding: contentPadding,
      actionsPadding: _actionsPadding,
      content: Text(content,
          textAlign: textAlign, style: Theme.of(context).textTheme.caption),
      actions: <Widget>[
        _cancelButton,
        _doneButton,
      ],
    );
  }
}
