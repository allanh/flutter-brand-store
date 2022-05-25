import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/app/widgets/member_profile/common.dart';

/// 建立地址輸入框
class AddressTile extends StatelessWidget {
  const AddressTile({
    Key? key,
    required this.context,
    required this.zipCode,
    required this.county,
    required this.district,
    required this.address,
    required this.handleChange,
  }) : super(key: key);

  final BuildContext context;
  final String? zipCode;
  final String? county;
  final String? district;
  final String? address;
  final void Function(String? p1) handleChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 149.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('地址',
                  style: TextStyle(
                      color: UdiColors.greyishBrown,
                      fontFamily: 'PingFangTC Semibold',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0)),
              const SizedBox(height: 8.0),
              Row(children: [
                Expanded(
                    child: HighlightTextField(
                        hintText: '郵遞區號',
                        handleChange: handleChange,
                        isHighlight: false)),
                const SizedBox(width: 10.0),
                Expanded(child: DropdownTextField(hintText: '縣市')),
                const SizedBox(width: 10.0),
                Expanded(child: DropdownTextField(hintText: '鄉鎮市區'))
              ]),
              const SizedBox(height: 8.0),
              HighlightTextField(
                  hintText: '請輸入街號、樓層',
                  handleChange: handleChange,
                  isHighlight: false),
              const SizedBox(height: 3.0),
              ErrorMessage(context: context, message: '請輸入有效地址')
            ])));
  }
}
