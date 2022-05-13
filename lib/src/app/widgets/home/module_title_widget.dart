import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/module/module.dart';

class ModuleTitleWidget extends StatelessWidget {
  const ModuleTitleWidget({
    Key? key,
    required this.module,
    required this.showMore,
  }) : super(key: key);
  @required
  final Module module;
  @required
  final bool showMore;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                module.title,
                style: theme.textTheme.bodyText2
                    ?.copyWith(color: theme.primaryColor),
              ),
              showMore
                  ? Text(
                      'MORE >',
                      style: theme.textTheme.caption
                          ?.copyWith(color: UdiColors.brownGrey),
                    )
                  : Container(),
            ],
          )),
    );
  }
}
