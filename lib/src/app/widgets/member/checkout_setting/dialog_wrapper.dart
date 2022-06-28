import 'package:flutter/material.dart';

import 'two_buttons_dialog.dart';

class DialogWrapper {
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
