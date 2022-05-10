import 'package:flutter/material.dart';

import '../../../domain/entities/module/module.dart';

class ModuleTitleWidget extends StatelessWidget {
  const ModuleTitleWidget({
    Key? key,
    required this.module,
  }) : super(key: key);
  @required
  final Module module;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 43,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 14.0, 12.0, 7.0),
        child: Text(module.title),
      ),
    );
  }
}
