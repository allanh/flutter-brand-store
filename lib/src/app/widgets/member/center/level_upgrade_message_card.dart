import 'package:flutter/material.dart';

class LevelUpgradeMessageCard extends StatelessWidget {
  const LevelUpgradeMessageCard({Key? key, required this.message})
      : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
        height: 40.0,
        child: Card(
            child: Text(message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white,
                      fontSize: 12.0,
                    )),
            color: theme.appBarTheme.backgroundColor,
            elevation: 4,
            margin: const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))));
  }
}
