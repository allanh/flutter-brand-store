import 'package:flutter/material.dart';
import 'package:brandstores/src/app/widgets/member/profile/common.dart';

/// 建立地址輸入框
class AddressTile extends StatelessWidget {
  const AddressTile({
    Key? key,
    required this.context,
    required this.zipCode,
    required this.county,
    required this.district,
    required this.address,
    required this.isValid,
    required this.handleCountyChange,
    required this.handleDistrictChange,
    required this.handleAddressChange,
  }) : super(key: key);

  final BuildContext context;
  final String? zipCode;
  final String? county;
  final String? district;
  final String? address;
  final bool isValid;
  final void Function() handleCountyChange;
  final void Function() handleDistrictChange;
  final void Function(String? p1) handleAddressChange;

  @override
  Widget build(BuildContext context) {
    var children = [
      Text(
        '地址',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14.0),
      ),
      const SizedBox(height: 8.0),
      Row(children: [
        Expanded(
            child: DropdownTextField(
          text: zipCode,
          hintText: '郵遞區號',
          isValid: isValid,
          handleTap: handleCountyChange,
          showArrow: false,
        )),
        const SizedBox(width: 10.0),
        Expanded(
            child: DropdownTextField(
          text: county,
          hintText: '縣市',
          isValid: isValid,
          handleTap: handleCountyChange,
          showArrow: true,
        )),
        const SizedBox(width: 10.0),
        Expanded(
            child: DropdownTextField(
          text: district,
          hintText: '鄉鎮市區',
          isValid: isValid,
          handleTap: handleDistrictChange,
          showArrow: true,
        ))
      ]),
      const SizedBox(height: 8.0),
      HighlightTextField(
          text: address,
          hintText: '請輸入街號、樓層',
          handleChange: handleAddressChange,
          isHighlight: isValid == false),
    ];
    if (isValid == false) {
      children.addAll([
        const SizedBox(height: 3.0),
        ErrorMessage(context: context, message: '請輸入有效地址')
      ]);
    }
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: isValid ? 125.0 : 149.0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children)));
  }
}
