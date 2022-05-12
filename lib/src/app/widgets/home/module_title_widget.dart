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
      height: 40,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(module.title),
              const Text('MORE >'),
            ],
          )),
    );
  }
}
