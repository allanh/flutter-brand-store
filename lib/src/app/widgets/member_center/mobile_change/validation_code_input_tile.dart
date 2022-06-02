import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';

class ValidationCodeInputTile extends StatefulWidget {
  const ValidationCodeInputTile({
    Key? key,
    required this.handleValidationCodeChange,
  }) : super(key: key);

  final void Function(String) handleValidationCodeChange;

  @override
  State<ValidationCodeInputTile> createState() =>
      _ValidationCodeInputTileState();
}

class _ValidationCodeInputTileState extends State<ValidationCodeInputTile> {
  bool isShowDescription = true;
  @override
  Widget build(BuildContext context) {
    double fieldWidth =
        (MediaQuery.of(context).size.width - 24.0 - 24.0 - 16.0 - 16.0 - 16.0) /
            4;

    Widget field = SizedBox(
      width: fieldWidth,
      child: TextField(
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge,
        maxLength: 1,
        onChanged: (text) => widget.handleValidationCodeChange(text),
        onTap: () => {setState(() => isShowDescription = false)},
        cursorColor: UdiColors.brownGrey2,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          counterText: '',
          hintStyle: TextStyle(color: UdiColors.brownGrey2),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: UdiColors.veryLightGrey2),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: UdiColors.veryLightGrey2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: UdiColors.veryLightGrey2),
          ),
        ),
      ),
    );

    List<Widget> children = [
      Padding(
        padding: const EdgeInsets.only(top: 42.0, left: 24.0, right: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            field,
            const SizedBox(width: 16.0),
            field,
            const SizedBox(width: 16.0),
            field,
            const SizedBox(width: 16.0),
            field
          ],
        ),
      ),
    ];

    if (isShowDescription) {
      children.add(Center(
        child: Text(
          '請輸入驗證簡訊4位數驗證碼',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: UdiColors.brownGrey),
        ),
      ));
    }

    return Stack(alignment: Alignment.center, children: children);
  }
}
