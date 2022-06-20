import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/member/member_profile.dart';

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
    Row _maleOptionRow = _buildRadioOptionRow(
      context,
      Gender.male,
      gender,
      '男性',
    );

    Row _femaleOptionRow = _buildRadioOptionRow(
      context,
      Gender.female,
      gender,
      '女性',
    );

    Row _otherOptionRow = _buildRadioOptionRow(
      context,
      Gender.other,
      gender,
      '不公開',
    );

    Text _title = Text(
      '性別',
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: UdiColors.greyishBrown,
            fontSize: 14.0,
          ),
    );

    Row _optionsRow = Row(
      children: [
        _maleOptionRow,
        const SizedBox(width: 12.0),
        _femaleOptionRow,
        const SizedBox(width: 12.0),
        _otherOptionRow
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 80.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title,
            _optionsRow,
          ],
        ),
      ),
    );
  }

  Row _buildRadioOptionRow(
    BuildContext context,
    Gender value,
    Gender? groupValue,
    String text,
  ) {
    return Row(
      children: [
        Radio<Gender>(
          value: value,
          groupValue: groupValue,
          visualDensity: const VisualDensity(
            vertical: -2.0,
            horizontal: -4.0,
          ),
          fillColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Theme.of(context).appBarTheme.backgroundColor!;
            }
            return UdiColors.brownGrey2;
          }),
          onChanged: handleGender,
        ),
        GestureDetector(
            onTap: () => handleGender(value),
            child: Text(
              text,
              style: Theme.of(context).textTheme.caption,
            ))
      ],
    );
  }
}
