import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';

/// 超連結樣式文字
class HyperLinkText extends StatelessWidget {
  const HyperLinkText({
    Key? key,
    required this.context,
    required this.text,
    required this.active,
  }) : super(key: key);

  final BuildContext context;
  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.caption!.copyWith(
            color: active
                ? Theme.of(context).appBarTheme.backgroundColor
                : UdiColors.brownGrey2,
            fontSize: 12.0,
          ),
    );
  }
}

/// 超連結樣式按鈕
class HyperLinkButton extends StatelessWidget {
  const HyperLinkButton({
    Key? key,
    required this.context,
    required this.text,
    required this.enable,
    required this.handleTap,
  }) : super(key: key);

  final BuildContext context;
  final String text;
  final bool enable;
  final void Function(String? p1) handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: HyperLinkText(context: context, text: text, active: enable),
      onTap: () => enable ? handleTap(text) : null,
    );
  }
}

/// 驗證結果文字
class ValidResultText extends StatelessWidget {
  const ValidResultText({
    Key? key,
    required this.isValid,
  }) : super(key: key);

  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Text(
      isValid ? '已驗證' : '未驗證',
      style: Theme.of(context).textTheme.caption!.copyWith(
            color: isValid ? UdiColors.green : UdiColors.strawberry,
            fontSize: 12.0,
          ),
    );
  }
}

/// 建立有星號(*)的文字
class RequiresText extends StatelessWidget {
  const RequiresText({
    Key? key,
    required this.context,
    required this.text,
  }) : super(key: key);

  final BuildContext context;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: UdiColors.greyishBrown,
                fontSize: 14.0,
              ),
          children: <TextSpan>[
            TextSpan(
              text: "*",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: UdiColors.strawberry,
                    fontSize: 14.0,
                  ),
            )
          ]),
    );
  }
}

/// 建立有狀態的文字輸入框
class HighlightTextField extends StatelessWidget {
  const HighlightTextField({
    Key? key,
    this.text,
    required this.hintText,
    required this.handleChange,
    required this.isHighlight,
  }) : super(key: key);

  final String? text;
  final String hintText;
  final void Function(String? p1) handleChange;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: isHighlight ? UdiColors.strawberry : UdiColors.veryLightGrey2,
      ),
    );

    return TextField(
        onChanged: handleChange,
        cursorColor: UdiColors.brownGrey2,
        decoration: InputDecoration(
            labelText: text,
            labelStyle: Theme.of(context).textTheme.caption!.copyWith(
                  color: UdiColors.greyishBrown,
                  fontSize: 16.0,
                ),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: _outlineInputBorder,
            enabledBorder: _outlineInputBorder,
            focusedBorder: _outlineInputBorder,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                  color: UdiColors.brownGrey2,
                  fontSize: 16.0,
                ),
            contentPadding: const EdgeInsets.only(
              left: 10.0,
              top: 40.0 / 4,
              bottom: 40.0 / 4,
            )));
  }
}

/// 建立有下拉箭頭的文字輸入匡
class DropdownTextField extends StatelessWidget {
  const DropdownTextField({
    Key? key,
    this.text,
    required this.hintText,
    required this.isValid,
    required this.handleTap,
    required this.showArrow,
  }) : super(key: key);

  final String? text;
  final String hintText;
  final bool isValid;
  final void Function() handleTap;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: (isValid) ? UdiColors.veryLightGrey2 : UdiColors.strawberry,
      ),
    );

    List<Widget> children = [
      TextField(
          enabled: false,
          cursorColor: UdiColors.brownGrey2,
          decoration: InputDecoration(
              labelText: text,
              labelStyle: Theme.of(context).textTheme.caption!.copyWith(
                    color: UdiColors.greyishBrown,
                    fontSize: 16.0,
                  ),
              isCollapsed: true,
              border: _outlineInputBorder,
              enabledBorder: _outlineInputBorder,
              focusedBorder: _outlineInputBorder,
              disabledBorder: _outlineInputBorder,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                    color: UdiColors.brownGrey2,
                    fontSize: 16.0,
                  ),
              contentPadding: const EdgeInsets.only(
                left: 10.0,
                top: 40.0 / 4,
                bottom: 40.0 / 4,
              ))),
    ];
    if (showArrow) {
      children.add(const Padding(
          padding: EdgeInsets.only(right: 9.8),
          child: Image(
            image: AssetImage('assets/images/icon_arrow_down.png'),
          )));
    }
    return GestureDetector(
        onTap: handleTap,
        child: Stack(
          alignment: Alignment.centerRight,
          children: children,
        ));
  }
}

/// 建立左邊有icon的錯誤訊息
class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    Key? key,
    required this.context,
    required this.message,
  }) : super(key: key);

  final BuildContext context;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Image(
        image: AssetImage('assets/images/icon_warning_red.png'),
      ),
      const SizedBox(
        width: 2.0,
      ),
      Text(message,
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: UdiColors.strawberry))
    ]);
  }
}

/// 建立文字輸入框
class InputTile extends StatelessWidget {
  const InputTile({
    Key? key,
    required this.context,
    required this.title,
    required this.text,
    required this.hintText,
    required this.errorText,
    required this.isValid,
    required this.handleChange,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final String? text;
  final String hintText;
  final String errorText;
  final bool isValid;
  final void Function(String? p1) handleChange;

  @override
  Widget build(BuildContext context) {
    HighlightTextField _highlightTextField = HighlightTextField(
      text: text,
      hintText: hintText,
      handleChange: handleChange,
      isHighlight: false,
    );

    RequiresText _requiresText = RequiresText(
      context: context,
      text: title,
    );

    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
          width: double.infinity,
          height: isValid ? 80.0 : 104.0,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: isValid
                  ? [
                      _requiresText,
                      const SizedBox(height: 8.0),
                      _highlightTextField,
                    ]
                  : [
                      _requiresText,
                      const SizedBox(height: 8.0),
                      _highlightTextField,
                      const SizedBox(height: 3.0),
                      ErrorMessage(context: context, message: errorText)
                    ]),
        ));
  }
}
