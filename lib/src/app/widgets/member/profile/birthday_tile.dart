import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

/// 建立生日選擇
class BrithdayTile extends StatelessWidget {
  const BrithdayTile({
    Key? key,
    required this.context,
    required this.enableChange,
    required this.birthday,
    required this.handleConfirm,
  }) : super(key: key);

  final BuildContext context;
  final bool enableChange;
  final String? birthday;
  final Function(DateTime p1)? handleConfirm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
      ),
      child: SizedBox(
          width: double.infinity,
          height: 80.0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('生日',
                style: TextStyle(
                    color: UdiColors.greyishBrown,
                    fontFamily: 'PingFangTC Semibold',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0)),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 40.0,
              child: GestureDetector(
                  onTap: () {
                    enableChange
                        ? DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            maxTime: DateTime.now(),
                            onConfirm: handleConfirm,
                            locale: LocaleType.tw,
                          )
                        : null;
                  },
                  child: TextField(
                    enabled: false,
                    readOnly: true,
                    cursorColor: UdiColors.brownGrey2,
                    decoration: InputDecoration(
                        hintText: '請選擇生日',
                        enabled: false,
                        suffixIcon: const Image(
                          image: AssetImage('assets/images/icon_date_picker.png'),
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: UdiColors.veryLightGrey2)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: UdiColors.veryLightGrey2)),
                        disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: UdiColors.veryLightGrey2)),
                        labelText: birthday,
                        labelStyle: TextStyle(
                            color: birthday != null
                                ? UdiColors.greyishBrown
                                : UdiColors.brownGrey2),
                        contentPadding: const EdgeInsets.only(
                          left: 10.0,
                          top: 40.0 / 4,
                          bottom: 40.0 / 4,
                        )),
                  )),
            ),
          ])),
    );
  }
}
