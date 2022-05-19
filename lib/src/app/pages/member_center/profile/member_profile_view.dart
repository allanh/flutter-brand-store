import 'package:brandstores/src/app/pages/member_center/profile/member_profile_controller.dart';
import 'package:brandstores/src/data/repositories/data_member_profile_repository.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class MemberProfilePage extends View {
  MemberProfilePage({Key? key}) : super(key: key);

  @override
  State<MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState
    extends ViewState<MemberProfilePage, MemberProfileController> {
  _MemberProfilePageState()
      : super(MemberProfileController(DataMemberProfileRepository()));

  Gender? _gender;

  void _handleGender(Gender? gender) {
    setState(() {
      _gender = gender;
    });
  }

  @override
  Widget get view {
    return Scaffold(
        appBar: AppBar(title: const Text('會員資料')),
        body: ControlledWidgetBuilder<MemberProfileController>(
            builder: (context, controller) {
          return ListView(children: [
            /// 生日修改次數說明
            _buildBirthdayChangeHint(context),

            /// 姓名區塊
            _buildTextField(context, '姓名', controller.memberProfile?.name,
                '請輸入姓名', '請輸入有效姓名'),

            /// 行動電話區塊
            _buildMobileTextField(context, controller.memberProfile?.mobile),

            /// Eamil 區塊
            _buildTextField(context, 'Email', controller.memberProfile?.name,
                '請輸入Email', '請輸入有效Email'),

            /// 市話區塊
            _buildPhoneTextField(context, controller.memberProfile?.area,
                controller.memberProfile?.phone, controller.memberProfile?.ext),

            /// 性別區塊
            _buildGenderRadioButtons(context, _gender, _handleGender),

            /// 生日區塊
            _buildBirthdayPicker(context, controller.memberProfile?.birthday)
          ]);
        }));
  }

  /// 建立生日選擇
  Padding _buildBirthdayPicker(BuildContext context, String? birthday) {
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
            _buildPingFangTCSemiboldText('生日'),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 40.0,
              child: GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        maxTime: DateTime.now(), onChanged: (date) {
                      debugPrint('change $date');
                    }, onConfirm: (date) {
                      debugPrint('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.tw);
                  },
                  child: const TextField(
                    readOnly: true,
                    cursorColor: UdiColors.brownGrey2,
                    decoration: InputDecoration(
                        enabled: false,
                        suffixIcon: Image(
                          image: AssetImage('assets/icon_date_picker.png'),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: UdiColors.veryLightGrey2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: UdiColors.veryLightGrey2)),
                        labelText: '請選擇生日',
                        contentPadding: EdgeInsets.only(
                          left: 10.0,
                          top: 40.0 / 4,
                          bottom: 40.0 / 4,
                        )),
                  )),
            ),
          ])),
    );
  }

  /// 建立性別選擇按鈕
  Padding _buildGenderRadioButtons(BuildContext context, Gender? gender,
      void Function(Gender?) handleGender) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: SizedBox(
          width: double.infinity,
          height: 80.0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildPingFangTCSemiboldText('性別'),
            Row(
              children: [
                _buildGenderRadioOptionRow(
                    context, '男性', Gender.male, gender, handleGender),
                const SizedBox(width: 12.0),
                _buildGenderRadioOptionRow(
                    context, '女性', Gender.female, gender, handleGender),
                const SizedBox(width: 12.0),
                _buildGenderRadioOptionRow(
                    context, '不公開', Gender.other, gender, handleGender),
              ],
            )
          ])),
    );
  }

  /// 建立性別選項
  Row _buildGenderRadioOptionRow(BuildContext context, String title,
      Gender value, Gender? groupValue, void Function(Gender?) handleChange) {
    return Row(
      children: [
        _buildRadio(context, value, groupValue, handleChange),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: UdiColors.greyishBrown))
      ],
    );
  }

  /// 建立 Radio 物件
  Radio<Gender> _buildRadio(BuildContext context, Gender value,
      Gender? groupValue, void Function(Gender?) handleChange) {
    return Radio<Gender>(
      value: value,
      groupValue: groupValue,
      visualDensity: const VisualDensity(vertical: -2.0, horizontal: -4.0),
      fillColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Theme.of(context).appBarTheme.backgroundColor!;
        }
        return UdiColors.brownGrey2;
      }),
      onChanged: handleChange,
    );
  }

  /// 建立市話輸入框
  Padding _buildPhoneTextField(
      BuildContext context, String? area, String? phone, String? ext) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 104.0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildPingFangTCSemiboldText('市話'),
          const SizedBox(height: 8.0),
          Row(
            children: [
              SizedBox(width: 90.0, child: _buildStateTextField(area, '區碼')),
              const SizedBox(width: 10.0),
              SizedBox(
                  width:
                      MediaQuery.of(context).size.width - 90.0 - 119.0 - 44.0,
                  child: _buildStateTextField(phone, '市內電話')),
              const SizedBox(width: 10.0),
              SizedBox(width: 119.0, child: _buildStateTextField(phone, '分機'))
            ],
          ),
          const SizedBox(height: 3.0),
          _buildErrorMessage(context, '請輸入有效市話')
        ]),
      ),
    );
  }

  /// 建立行動電話輸入框
  Padding _buildMobileTextField(BuildContext context, String? mobile) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 104.0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildRequiresText(context, '手機'),
          const SizedBox(height: 8.0),
          Row(
            children: [
              SizedBox(width: 84.0, child: _buildStateTextField('+886', '')),
              const SizedBox(width: 10.0),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 84.0 - 34.0,
                  child: _buildStateTextField(mobile, '請輸入手機號碼'))
            ],
          ),
          const SizedBox(height: 3.0),
          _buildErrorMessage(context, '請輸入有效手機號碼')
        ]),
      ),
    );
  }

  /// 建立生日修改提示說明
  Padding _buildBirthdayChangeHint(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
        child: SizedBox(
            width: double.infinity,
            height: 48.0,
            child: Text('作為系統預設之訂購人資料，請務必填寫正確(生日僅可修改一次)。',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: UdiColors.brownGrey))));
  }

  /// 建立文字輸入框
  Padding _buildTextField(BuildContext context, String title, String? text,
      String hintText, String errorText) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
          width: double.infinity,
          height: 104.0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildRequiresText(context, title),
            const SizedBox(height: 8.0),
            _buildStateTextField(text, hintText),
            const SizedBox(height: 3.0),
            _buildErrorMessage(context, errorText)
          ]),
        ));
  }

  /// 建立左邊有icon的錯誤訊息
  Row _buildErrorMessage(BuildContext context, String message) {
    return Row(children: [
      const Image(
        image: AssetImage('assets/icon_warning_red.png'),
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

  /// 建立有狀態的文字輸入框
  TextField _buildStateTextField(String? labelText, String hintText) {
    return TextField(
        cursorColor: UdiColors.brownGrey2,
        decoration: InputDecoration(
            isCollapsed: true,
            border: _buildStateBorder(labelText != null),
            enabledBorder: _buildStateBorder(labelText != null),
            focusedBorder: _buildStateBorder(labelText != null),
            hintText: hintText,
            hintStyle: const TextStyle(color: UdiColors.brownGrey2),
            labelText: labelText,
            contentPadding: const EdgeInsets.only(
              left: 10.0,
              top: 40.0 / 4,
              bottom: 40.0 / 4,
            )));
  }

  /// 建立有狀態的邊匡
  OutlineInputBorder _buildStateBorder(bool valid) {
    return OutlineInputBorder(
        borderSide: BorderSide(
            width: 1.0,
            color: valid ? UdiColors.veryLightGrey2 : UdiColors.strawberry));
  }

  /// 建立有星號(*)的文字
  RichText _buildRequiresText(BuildContext context, String text) {
    return RichText(
      text: TextSpan(
          text: text,
          style: _buildPingFangTCSemiboldStyle(UdiColors.greyishBrown),
          children: <TextSpan>[
            TextSpan(
                text: "*",
                style: _buildPingFangTCSemiboldStyle(UdiColors.strawberry))
          ]),
    );
  }

  /// 建立粗體字體
  Text _buildPingFangTCSemiboldText(String text) {
    return Text(text,
        style: _buildPingFangTCSemiboldStyle(UdiColors.greyishBrown));
  }

  /// 建立粗體字樣式
  TextStyle _buildPingFangTCSemiboldStyle(Color color) {
    return TextStyle(
        color: color,
        fontFamily: 'PingFangTC Semibold',
        fontWeight: FontWeight.w600,
        fontSize: 14.0);
  }
}
