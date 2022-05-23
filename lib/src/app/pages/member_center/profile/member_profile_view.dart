import 'package:brandstores/src/app/pages/member_center/profile/member_profile_controller.dart';
import 'package:brandstores/src/data/repositories/data_member_profile_repository.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

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

  String? _birthday;

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
                '請輸入姓名', '請輸入有效姓名', (char) {
              debugPrint('Input $char');
            }, () {
              debugPrint('Editing complete');
            }, (result) {
              debugPrint('Submit $result');
            }),

            /// 行動電話區塊
            _buildMobileView(
                context,
                controller.memberProfile?.sensitiveMobile ?? '',
                // controller.memberProfile?.isVerifyMobile ??
                false, (message) {
              debugPrint(message);
            }),
            _buildValidationCodeTextField(context, ''),
            _buildMobileTextField(context, controller.memberProfile?.mobile,
                (char) {
              debugPrint('Input $char');
            }, () {
              debugPrint('Editing complete');
            }, (result) {
              debugPrint('Submit $result');
            }),

            /// Eamil 區塊
            _buildEmailView(context, controller.memberProfile?.email ?? '',
                controller.memberProfile?.isVerifyEmail ?? false, (message) {
              debugPrint(message);
            }),
            _buildTextField(context, 'Email', controller.memberProfile?.email,
                '請輸入Email', '請輸入有效Email', (char) {
              debugPrint('Input $char');
            }, () {
              debugPrint('Editing complete');
            }, (result) {
              debugPrint('Submit $result');
            }),

            /// 市話區塊
            _buildPhoneTextField(
                context,
                controller.memberProfile?.area,
                controller.memberProfile?.phone,
                controller.memberProfile?.ext, (char) {
              debugPrint('Input $char');
            }, () {
              debugPrint('Editing complete');
            }, (result) {
              debugPrint('Submit $result');
            }),

            /// 性別區塊
            _buildGenderRadioButtons(context, _gender, (gender) {
              setState(() {
                debugPrint(gender.toString());
                _gender = gender;
              });
            }),

            /// 生日區塊
            _buildBirthdayPicker(
              context,
              _birthday,
              (date) {
                debugPrint('confirm $date');
                setState(() {
                  final DateFormat formatter = DateFormat('yyyy/MM/dd');
                  _birthday = formatter.format(date);
                });
              },
            ),

            /// 地址
            _buildAddressTextFields(
                context,
                controller.memberProfile?.zipCode,
                controller.memberProfile?.city,
                controller.memberProfile?.area,
                controller.memberProfile?.address, (char) {
              debugPrint('Input $char');
            }, (result) {
              debugPrint('Submit $result');
            }),

            /// 密碼設定
            _buildPasswordSettingView(
                context, controller.memberProfile?.isSettingPassword ?? false,
                (message) {
              debugPrint(message);
            })
          ]);
        }));
  }

  /// 建立密碼設定區塊
  Padding _buildPasswordSettingView(BuildContext context,
      bool isSettingPassword, void Function(String) handleTap) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 80.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildPingFangTCSemiboldText('密碼'),
              const SizedBox(height: 8.0),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      _buildPingFangTCRegularText(
                          isSettingPassword ? '************' : '-'),
                    ]),
                    Row(
                        children: isSettingPassword
                            ? [_buildHyperLinkButton('修改密碼', handleTap)]
                            : [_buildHyperLinkButton('設定密碼', handleTap)])
                  ])
            ])));
  }

  /// 建立生日選擇
  Padding _buildBirthdayPicker(
    BuildContext context,
    String? birthday,
    dynamic Function(DateTime)? handleConfirm,
  ) {
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
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      maxTime: DateTime.now(),
                      onConfirm: handleConfirm,
                      locale: LocaleType.tw,
                    );
                  },
                  child: TextField(
                    readOnly: true,
                    cursorColor: UdiColors.brownGrey2,
                    decoration: InputDecoration(
                        enabled: false,
                        suffixIcon: const Image(
                          image: AssetImage('assets/icon_date_picker.png'),
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: UdiColors.veryLightGrey2)),
                        disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: UdiColors.veryLightGrey2)),
                        labelText: birthday ?? '請選擇生日',
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
        GestureDetector(
            onTap: () => handleChange(value),
            child: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: UdiColors.greyishBrown)))
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
    BuildContext context,
    String? area,
    String? phone,
    String? ext,
    void Function(String?) handleChange,
    void Function()? handleEditingComplete,
    void Function(String)? handleSubmitted,
  ) {
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
              SizedBox(
                  width: 90.0,
                  child: _buildStateTextField(
                      area, '區碼', handleChange, handleSubmitted)),
              const SizedBox(width: 10.0),
              Expanded(
                  child: _buildStateTextField(
                      phone, '市內電話', handleChange, handleSubmitted)),
              const SizedBox(width: 10.0),
              SizedBox(
                  width: 119.0,
                  child: _buildStateTextField(
                      phone, '分機', handleChange, handleSubmitted))
            ],
          ),
          const SizedBox(height: 3.0),
          _buildErrorMessage(context, '請輸入有效市話')
        ]),
      ),
    );
  }

  /// 建立地址輸入框
  Padding _buildAddressTextFields(
    BuildContext context,
    String? zipCode,
    String? county,
    String? district,
    String? address,
    void Function(String?) handleChange,
    void Function(String)? handleSubmitted,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 149.0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildPingFangTCSemiboldText('地址'),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                  child: _buildStateTextField(
                      zipCode, '郵遞區號', handleChange, handleSubmitted)),
              const SizedBox(width: 10.0),
              Expanded(child: _buildDropdownTextField(county, '縣市')),
              const SizedBox(width: 10.0),
              Expanded(child: _buildDropdownTextField(district, '鄉鎮市區'))
            ],
          ),
          const SizedBox(height: 8.0),
          _buildStateTextField(
              address, '請輸入街號、樓層', handleChange, handleSubmitted),
          const SizedBox(height: 3.0),
          _buildErrorMessage(context, '請輸入有效地址')
        ]),
      ),
    );
  }

  /// 建立驗證碼輸入匡
  Padding _buildValidationCodeTextField(BuildContext context, String? code) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 104.0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                  child: TextField(
                      cursorColor: UdiColors.brownGrey2,
                      decoration: InputDecoration(
                          isCollapsed: true,
                          border: _buildStateBorder(true),
                          enabledBorder: _buildStateBorder(true),
                          focusedBorder: _buildStateBorder(true),
                          hintText: '請輸入驗證碼',
                          hintStyle:
                              const TextStyle(color: UdiColors.brownGrey2),
                          contentPadding: const EdgeInsets.only(
                            left: 10.0,
                            top: 40.0 / 4,
                            bottom: 40.0 / 4,
                          )))),
              const SizedBox(width: 12.0),
              SizedBox(
                  width: 80.0,
                  height: 40.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).appBarTheme.backgroundColor),
                    onPressed: () {},
                    child: const Text('提交'),
                  ))
            ],
          ),
          const SizedBox(height: 4.0),
          const Text('請耐心等候驗證簡訊，約300秒後可重新發送。',
              style: TextStyle(
                  fontFamily: 'PingFangTC Regular',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: UdiColors.brownGrey2))
        ]),
      ),
    );
  }

  /// 建立行動電話顯示
  Padding _buildMobileView(BuildContext context, String sensitiveMobile,
      bool isValidation, void Function(String) handleTap) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 80.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildRequiresText(context, '手機'),
              const SizedBox(height: 8.0),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      _buildPingFangTCRegularText(sensitiveMobile),
                      const SizedBox(width: 10.0),
                      isValidation
                          ? const Image(
                              image: AssetImage('assets/icon_completed.png'))
                          : const Image(
                              image: AssetImage(
                                  'assets/icon_warning_red_circle.png')),
                      _buildValidResultText(isValidation)
                    ]),
                    Row(
                        children: isValidation
                            ? [_buildHyperLinkButton('手機變更', handleTap)]
                            : [
                                _buildHyperLinkButton('發送驗證碼', handleTap),
                                const SizedBox(width: 4),
                                _buildHyperLinkButton('手機變更', handleTap)
                              ])
                  ])
            ])));
  }

  /// 建立Email顯示
  Padding _buildEmailView(BuildContext context, String email, bool isValidation,
      void Function(String) handleTap) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 80.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildRequiresText(context, 'Email'),
              const SizedBox(height: 8.0),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      _buildPingFangTCRegularText(email),
                      const SizedBox(width: 10.0),
                      isValidation
                          ? const Image(
                              image: AssetImage('assets/icon_completed.png'))
                          : const Image(
                              image: AssetImage(
                                  'assets/icon_warning_red_circle.png')),
                      _buildValidResultText(isValidation)
                    ]),
                    Row(
                        children: isValidation
                            ? [_buildHyperLinkButton('Email變更', handleTap)]
                            : [
                                _buildHyperLinkButton('發送驗證信', handleTap),
                                const SizedBox(width: 4),
                                _buildHyperLinkButton('Email變更', handleTap)
                              ])
                  ])
            ])));
  }

  GestureDetector _buildHyperLinkButton(
      String text, void Function(String) handleTap) {
    return GestureDetector(
      child: _buildHyperLinkText(text),
      onTap: () => handleTap(text),
    );
  }

  /// 建立行動電話輸入框
  Padding _buildMobileTextField(
    BuildContext context,
    String? mobile,
    void Function(String?) handleChange,
    void Function()? handleEditingComplete,
    void Function(String)? handleSubmitted,
  ) {
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
              SizedBox(
                  width: 84.0,
                  child: _buildStateTextField(
                      '+886', '', handleChange, handleSubmitted)),
              const SizedBox(width: 10.0),
              Expanded(
                  child: _buildStateTextField(
                      mobile, '請輸入手機號碼', handleChange, handleSubmitted))
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
  Padding _buildTextField(
    BuildContext context,
    String title,
    String? text,
    String hintText,
    String errorText,
    void Function(String?) handleChange,
    void Function()? handleEditingComplete,
    void Function(String)? handleSubmitted,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
          width: double.infinity,
          height: 104.0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildRequiresText(context, title),
            const SizedBox(height: 8.0),
            _buildStateTextField(text, hintText, handleChange, handleSubmitted),
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

  /// 建立有下拉箭頭的文字輸入匡
  GestureDetector _buildDropdownTextField(String? labelText, String hintText) {
    return GestureDetector(
        onTap: () {
          debugPrint('$hintText button pressed');
        },
        child: Stack(alignment: Alignment.centerRight, children: [
          TextField(
              enabled: false,
              cursorColor: UdiColors.brownGrey2,
              decoration: InputDecoration(
                  isCollapsed: true,
                  border: _buildStateBorder(true),
                  enabledBorder: _buildStateBorder(true),
                  focusedBorder: _buildStateBorder(true),
                  disabledBorder: _buildStateBorder(true),
                  hintText: hintText,
                  hintStyle: const TextStyle(color: UdiColors.brownGrey2),
                  labelText: labelText,
                  contentPadding: const EdgeInsets.only(
                    left: 10.0,
                    top: 40.0 / 4,
                    bottom: 40.0 / 4,
                  ))),
          const Padding(
              padding: EdgeInsets.only(right: 9.8),
              child: Image(
                image: AssetImage('assets/icon_arrow_down.png'),
              ))
        ]));
  }

  /// 建立有狀態的文字輸入框
  TextField _buildStateTextField(
    String? labelText,
    String hintText,
    void Function(String?) handleChange,
    void Function(String)? handleSubmitted,
  ) {
    return TextField(
        onSubmitted: handleSubmitted,
        onChanged: handleChange,
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

  /// 建立一般字體
  Text _buildPingFangTCRegularText(String text) {
    return Text(text,
        style: _buildPingFangTCRegularStyle(UdiColors.greyishBrown));
  }

  /// 建立一般字樣式
  TextStyle _buildPingFangTCRegularStyle(Color color) {
    return TextStyle(
        color: color,
        fontFamily: 'PingFangTC Regular',
        fontWeight: FontWeight.w400,
        fontSize: 14.0);
  }

  /// 建立驗證結果文字
  Text _buildValidResultText(bool isValid) {
    return Text(isValid ? '已驗證' : '未驗證',
        style: _buildValidResultStyle(
            isValid ? UdiColors.green : UdiColors.strawberry));
  }

  TextStyle _buildValidResultStyle(Color color) {
    return TextStyle(
        color: color,
        fontFamily: 'PingFangTC Regular',
        fontWeight: FontWeight.w400,
        fontSize: 12.0);
  }

  /// 建立超連結文字
  Text _buildHyperLinkText(String text) {
    return Text(text,
        style: const TextStyle(
            color: Color.fromRGBO(102, 106, 209, 1),
            fontFamily: 'PingFangTC Regular',
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
            decoration: TextDecoration.underline));
  }
}
