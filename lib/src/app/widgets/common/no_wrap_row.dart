import 'package:flutter/material.dart';

/// A widget that displays its children in single horizontal runs.
class NoWrapRow extends StatelessWidget {
  const NoWrapRow(
      {Key? key,
      required this.children,
      required this.maxHeight,
      this.minHeight,
      this.spacing})
      : super(key: key);

  final List<Widget> children;
  final double? spacing; // gap between adjacent children
  final double? minHeight;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          constraints:
              BoxConstraints(minHeight: minHeight ?? 0, maxHeight: maxHeight),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Wrap(
                verticalDirection: VerticalDirection.down,
                spacing: spacing ?? 0, // gap between adjacent chips
                children: children),
          ),
        ),
      ],
    );
  }
}
