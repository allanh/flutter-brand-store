import 'package:flutter/material.dart';

import 'package:brandstores/src/device/utils/my_plus_colors.dart';

class ResultDescriptionView extends StatelessWidget {
  const ResultDescriptionView({
    Key? key,
    required this.context,
    required this.image,
    required this.description,
    required this.completedButton,
  }) : super(key: key);

  final BuildContext context;
  final String image;
  final String description;
  final Widget completedButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 112.0),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 120.0,
              height: 120.0,
              child: Image(image: AssetImage(image)),
            ),
            const SizedBox(height: 22.0),
            SizedBox(
              height: 44.0,
              child: Text(description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: UdiColors.brownGrey)),
            ),
            completedButton,
          ],
        ),
      ),
    );
  }
}
