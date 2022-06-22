import 'package:flutter/material.dart';

import '../account_change/result_description_view.dart';

class BindingCompletedView extends StatelessWidget {
  const BindingCompletedView({
    Key? key,
    required this.social,
  }) : super(key: key);

  final String social;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('綁定帳號'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ResultDescriptionView(
        context: context,
        image: 'assets/images/icon_completed_stroke.png',
        description: '已完成綁定！\n下次登入時可使用$social帳號快速登入！',
        completedButton: Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
          child: SizedBox(
              height: 36.0,
              width: MediaQuery.of(context).size.width - 24.0 - 24.0,
              child: ElevatedButton(
                child: const Text('確定'),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).appBarTheme.backgroundColor),
                onPressed: () => Navigator.pop(context),
              )),
        ),
      ),
    );
  }
}
