import 'package:flutter/material.dart';

class DefaultIndicator extends StatelessWidget {
  const DefaultIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 18.0,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: const Center(
          child: Text(
        '預設',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
      )),
    );
  }
}
