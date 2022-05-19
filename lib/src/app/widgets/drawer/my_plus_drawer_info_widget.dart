import 'package:flutter/material.dart';

import '../../../domain/entities/site_setting/store_setting/basic.dart';


class MyPlusDrawerInfo extends StatelessWidget {
  const MyPlusDrawerInfo({
    Key? key,
    required this.enabled,
    required this.basic,
  }) : super(key: key);

  final bool enabled;
  final Basic basic;

  List<Widget> _storeInfo(ThemeData theme, Basic basic) {
    return [
      Text(basic.name, style: theme.textTheme.caption),
      Text(basic.store.phone, style: theme.textTheme.caption),
      Text(basic.email, style: theme.textTheme.caption),
      Text(basic.store.businessHour, style: theme.textTheme.caption),
      Text(basic.store.address.toString(), style: theme.textTheme.caption),
      Text('© 2020-2021  ${basic.name} 版權所有', style: theme.textTheme.caption),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: (enabled)
              ? _storeInfo(theme, basic)
              : [
                  Text('© 2020-2021  ${basic.name} 版權所有',
                      style: theme.textTheme.caption)
                ],
        ),
      ));
  }
}