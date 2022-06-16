import 'package:flutter/material.dart';

class DefaultIndicator extends StatelessWidget {
  const DefaultIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _themeColor = Theme.of(context).appBarTheme.backgroundColor!;

    TextStyle _style = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(color: Colors.white, fontSize: 12.0);

    return Container(
      width: 40.0,
      height: 18.0,
      color: _themeColor,
      child: Center(
          child: Text(
        '預設',
        style: _style,
      )),
    );
  }
}
