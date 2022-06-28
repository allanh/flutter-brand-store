import 'package:flutter/material.dart';

import 'two_buttons_dialog.dart';

class DialogWrapper {
  /// 取消、確定按鈕對話視窗
  ///
  /// [title] 有值時，會出現標題列以及關閉按鈕
  Future<String?> showTwoButtonsDialog({
    required BuildContext context,
    String? title,
    required String content,
    required EdgeInsets contentPadding,
    required TextAlign textAlign,
    required Function handleCancel,
    required Function handleSubmit,
  }) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => TwoButtonsDialog(
        title: title,
        content: content,
        contentPadding: contentPadding,
        textAlign: textAlign,
        handleCancel: handleCancel,
        handleSubmit: handleSubmit,
      ),
    );
  }
}
