import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/app/widgets/member_profile/common.dart';

/// 建立市話輸入框
class PhoneTile extends StatelessWidget {
  const PhoneTile({
    Key? key,
    required this.context,
    required this.area,
    required this.phone,
    required this.ext,
    required this.handleChange,
  }) : super(key: key);

  final BuildContext context;
  final String? area;
  final String? phone;
  final String? ext;
  final void Function(String? p1) handleChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 104.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('市話',
                  style: TextStyle(
                      color: UdiColors.greyishBrown,
                      fontFamily: 'PingFangTC Semibold',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0)),
              const SizedBox(height: 8.0),
              Row(children: [
                SizedBox(
                    width: 90.0,
                    child: HighlightTextField(
                        hintText: '區碼',
                        handleChange: handleChange,
                        isHighlight: false)),
                const SizedBox(width: 10.0),
                Expanded(
                    child: HighlightTextField(
                        hintText: '市內電話',
                        handleChange: handleChange,
                        isHighlight: false)),
                const SizedBox(width: 10.0),
                SizedBox(
                    width: 119.0,
                    child: HighlightTextField(
                        hintText: '分機',
                        handleChange: handleChange,
                        isHighlight: false))
              ]),
              const SizedBox(height: 3.0),
              ErrorMessage(context: context, message: '請輸入有效市話')
            ])));
  }
}
