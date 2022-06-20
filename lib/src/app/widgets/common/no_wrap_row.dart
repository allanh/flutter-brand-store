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
          // 限制單行高度
          constraints:
              BoxConstraints(minHeight: minHeight ?? 0, maxHeight: maxHeight),
          // 不會捲動的 ScrollView，第二行後不顯示
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
