import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';

/// 建立性別選擇按鈕
class GenderTile extends StatelessWidget {
  const GenderTile({
    Key? key,
    required this.context,
    required this.gender,
    required this.handleGender,
  }) : super(key: key);

  final BuildContext context;
  final Gender? gender;
  final void Function(Gender? p1) handleGender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: SizedBox(
          width: double.infinity,
          height: 80.0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('性別',
                style: TextStyle(
                    color: UdiColors.greyishBrown,
                    fontFamily: 'PingFangTC Semibold',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0)),
            Row(
              children: [
                Row(children: [
                  Radio<Gender>(
                    value: Gender.male,
                    groupValue: gender,
                    visualDensity:
                        const VisualDensity(vertical: -2.0, horizontal: -4.0),
                    fillColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context).appBarTheme.backgroundColor!;
                      }
                      return UdiColors.brownGrey2;
                    }),
                    onChanged: handleGender,
                  ),
                  GestureDetector(
                      onTap: () => handleGender(Gender.male),
                      child: Text('男性',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(color: UdiColors.greyishBrown)))
                ]),
                const SizedBox(width: 12.0),
                Row(children: [
                  Radio<Gender>(
                    value: Gender.female,
                    groupValue: gender,
                    visualDensity:
                        const VisualDensity(vertical: -2.0, horizontal: -4.0),
                    fillColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context).appBarTheme.backgroundColor!;
                      }
                      return UdiColors.brownGrey2;
                    }),
                    onChanged: handleGender,
                  ),
                  GestureDetector(
                      onTap: () => handleGender(Gender.female),
                      child: Text('女性',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(color: UdiColors.greyishBrown)))
                ]),
                const SizedBox(width: 12.0),
                Row(children: [
                  Radio<Gender>(
                    value: Gender.other,
                    groupValue: gender,
                    visualDensity:
                        const VisualDensity(vertical: -2.0, horizontal: -4.0),
                    fillColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context).appBarTheme.backgroundColor!;
                      }
                      return UdiColors.brownGrey2;
                    }),
                    onChanged: handleGender,
                  ),
                  GestureDetector(
                      onTap: () => handleGender(Gender.other),
                      child: Text('不公開',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(color: UdiColors.greyishBrown)))
                ]),
              ],
            )
          ])),
    );
  }
}
