import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText(
    this.errorMessage, {
    Key? key,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.paddingStart = 0,
    this.paddingEnd = 0,
  }) : super(key: key);

  final String? errorMessage;
  final int? maxLines;
  final TextOverflow? overflow;
  final double paddingStart;
  final double paddingEnd;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: errorMessage != null,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: paddingStart),
          const Icon(Icons.warning_rounded, color: UdiColors.danger, size: 20),
          const SizedBox(width: 4),
          Flexible(
              child: Text(
            errorMessage ?? '',
            overflow: maxLines == null ? null : overflow,
            maxLines: maxLines,
            softWrap: maxLines != 1,
            style: const TextStyle(color: UdiColors.danger),
          )),
          SizedBox(width: paddingEnd)
        ]));
  }
}
