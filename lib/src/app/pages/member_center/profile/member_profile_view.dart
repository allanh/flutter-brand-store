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

  String? _validationCode;

  bool _showValidationView = false;

  @override
  Widget get view {
    return Scaffold(
        appBar: AppBar(title: const Text('會員資料')),
        body: ControlledWidgetBuilder<MemberProfileController>(
            builder: (context, controller) {
          final MemberProfile? profile = controller.memberProfile;
          return ListView(children: [
            /// 生日修改次數說明
            _buildBirthdayChangeHint(context),

            /// 姓名區塊
            _buildInputTile(context, '姓名', profile?.name, '請輸入姓名', '請輸入有效姓名',
                controller.validateName(profile?.name), (char) {
              debugPrint('Input $char');
              controller.updateName(char);
            }),

            /// 行動電話區塊
            _buildMobileCard(
                context,
                profile?.countryCode,
                profile?.mobile,
                profile?.isVerifyMobile,
                controller.validateCountryCode(profile?.countryCode),
                controller.validateMobile(profile?.mobile), (code) {
              controller.updateCountryCode(code);
            }, (result) {
              controller.updateMobile(result);
            }),

            /// Eamil 區塊
            _buildEmailCard(context, controller, profile),

            /// 市話區塊
            _buildPhoneTile(
                context, profile?.area, profile?.phone, profile?.ext, (char) {
              debugPrint('Input $char');
            }),

            /// 性別區塊
            _buildGenderTile(context, _gender, (gender) {
              setState(() {
                debugPrint(gender.toString());
                _gender = gender;
              });
            }),

            /// 生日區塊
            _buildBirthdayTile(
              context,
              controller,
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
            _buildAddressTile(context, profile?.zipCode, profile?.city,
                profile?.area, profile?.address, (char) {
              debugPrint('Input $char');
            }),

            /// 密碼設定
            _buildPasswordSettingTile(
                context, profile?.isSettingPassword ?? false, (message) {
              debugPrint(message);
            }),

            /// 儲存按鈕
            _buildSaveButton(context, () {
              debugPrint('save button pressed');
            }),

            /// 分隔線
            const Divider(
                thickness: 1.0,
                indent: 12.0,
                endIndent: 12.0,
                color: UdiColors.veryLightGrey2),

            /// 綁定帳號提示
            _buildBindingHintTile(context),

            /// Facebook帳號綁定
            _buildBindingTile(
                context,
                profile?.bindingInfo?.facebookBinding,
                profile?.bindingInfo?.facebookBindingImage ?? '',
                profile?.bindingInfo?.facebookBinding?.bindingId != null,
                (binding) {
              debugPrint('Facebook binding button pressed');
            }),

            /// Google帳號綁定
            _buildBindingTile(
                context,
                profile?.bindingInfo?.googleBinding,
                profile?.bindingInfo?.googleBindingImage ?? '',
                profile?.bindingInfo?.googleBinding?.bindingId != null,
                (binding) {
              debugPrint('Google binding button pressed');
            }),

            /// Line帳號綁定
            _buildBindingTile(
                context,
                profile?.bindingInfo?.lineBinding,
                profile?.bindingInfo?.lineBindingImage ?? '',
                profile?.bindingInfo?.lineBinding?.bindingId != null,
                (binding) {
              debugPrint('Line binding button pressed');
            }),

            /// Apple帳號綁定
            _buildBindingTile(
                context,
                profile?.bindingInfo?.appleBinding,
                profile?.bindingInfo?.appleBindingImage ?? '',
                profile?.bindingInfo?.appleBinding?.bindingId != null,
                (binding) {
              debugPrint('Apple binding button pressed');
            }),
          ]);
        }));
  }

  Column _buildEmailCard(
    BuildContext context,
    MemberProfileController controller,
    MemberProfile? profile,
  ) {
    return Column(children: [
      profile?.email != null && profile?.isVerifyEmail == true
          ? _buildEmailTile(context, controller, profile?.email ?? '',
              profile?.isVerifyEmail ?? false, (message) {
              debugPrint(message);
            })
          : _buildInputTile(context, 'Email', profile?.email, '請輸入Email',
              '請輸入有效Email', controller.validateEmail(profile?.email), (char) {
              debugPrint('Input $char');
              controller.updateEmail(char);
            })
    ]);
  }

  Column _buildMobileCard(
    BuildContext context,
    String? countryCode,
    String? mobile,
    bool? isVerify,
    bool isValidCountryCode,
    bool isValidMobile,
    void Function(String?) handleCountryCodeChange,
    void Function(String?) handleMobileChange,
  ) {
    var mobileTile =
        _buildMobileTile(context, mobile ?? '', isVerify ?? false, (code) {
      setState(() {
        _showValidationView = true;
      });
    }, (message) {
      debugPrint(message);
    });
    var validationCodeTile = _buildValidationCodeTile(context, '', (code) {
      _validationCode = code;
    }, (code) {
      debugPrint(code);
      setState(() {
        if (code != null && code.isEmpty == false) {
          _showValidationView = false;
        }
      });
    });
    var mobileInputTile = _buildMobileInputTile(
        context,
        mobile,
        isValidCountryCode,
        isValidMobile,
        handleCountryCodeChange,
        handleMobileChange);
    return Column(
        children:

            /// 有行動電話資料
            mobile != null

                /// 使用者尚未點擊發送驗證碼按鈕
                ? _showValidationView == false

                    /// 顯示行動電話
                    ? [mobileTile]

                    /// 使用者點擊發送驗證碼按鈕，顯示驗證碼輸入框
                    : [
                        mobileTile,
                        validationCodeTile,
                      ]

                /// 沒有行動電話資料，顯示輸入框
                : [mobileInputTile]);
  }

  /// 建立綁定畫面
  Padding _buildBindingTile(
    BuildContext context,
    Binding? binding,
    String image,
    bool isBinding,
    void Function(Binding?) handleBinding,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: SizedBox(
            width: double.infinity,
            height: 66.0,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image(height: 46.0, width: 46.0, image: AssetImage(image)),
                    const SizedBox(width: 16.0),
                    Text(isBinding ? '已綁定' : '尚未綁定',
                        style:
                            _buildPingFangTCRegularStyle(UdiColors.brownGrey))
                  ]),
                  Row(children: [
                    isBinding
                        ? OutlinedButton(
                            onPressed: () => handleBinding(binding),
                            child: Text('解除綁定',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor)))
                        : ElevatedButton(
                            onPressed: () => handleBinding(binding),
                            child: const Text('立即綁定'),
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor))
                  ])
                ])));
  }

  /// 建立帳號綁定提示
  Padding _buildBindingHintTile(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: SizedBox(
            width: double.infinity,
            height: 75.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 30.0,
                    child: Row(
                      children: [
                        /// 「綁定帳號」文字右邊的線條
                        Container(
                          height: 20.0,
                          width: 2.0,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                        const SizedBox(width: 9.0),
                        _buildPingFangTCSemiboldText('綁定帳號')
                      ],
                    )),
                const SizedBox(width: 9.0),
                SizedBox(
                    height: 24.0,
                    child: _buildPingFangTCRegularText('綁定帳號後，下次可使用這些帳號快速登入。',
                        color: UdiColors.brownGrey))
              ],
            )));
  }

  /// 建立儲存按鈕
  Padding _buildSaveButton(
    BuildContext context,
    void Function() handleSave,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
        child: SizedBox(
            width: double.infinity,
            height: 36.0,
            child: ElevatedButton(
                child: const Text('儲存'),
                onPressed: handleSave,
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).appBarTheme.backgroundColor,
                    textStyle: const TextStyle(
                        color: UdiColors.white,
                        fontFamily: 'PingFangTC Semibold',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0)))));
  }

  /// 建立密碼設定區塊
  Padding _buildPasswordSettingTile(
    BuildContext context,
    bool isSettingPassword,
    void Function(String?) handleTap,
  ) {
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
                    Row(children: [
                      isSettingPassword
                          ? _buildHyperLinkButton(
                              context, '修改密碼', true, handleTap)
                          : _buildHyperLinkButton(
                              context, '設定密碼', true, handleTap)
                    ])
                  ])
            ])));
  }

  /// 建立生日選擇
  Padding _buildBirthdayTile(
    BuildContext context,
    MemberProfileController controller,
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
                        hintText: '請選擇生日',
                        enabled: false,
                        suffixIcon: const Image(
                          image: AssetImage('assets/icon_date_picker.png'),
                        ),
                        border: _buildHighlightBorder(),
                        disabledBorder: _buildHighlightBorder(),
                        labelText: _birthday,
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
  Padding _buildGenderTile(
    BuildContext context,
    Gender? gender,
    void Function(Gender?) handleGender,
  ) {
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
                _buildGenderOption(
                    context, '男性', Gender.male, gender, handleGender),
                const SizedBox(width: 12.0),
                _buildGenderOption(
                    context, '女性', Gender.female, gender, handleGender),
                const SizedBox(width: 12.0),
                _buildGenderOption(
                    context, '不公開', Gender.other, gender, handleGender),
              ],
            )
          ])),
    );
  }

  /// 建立性別選項
  Row _buildGenderOption(
    BuildContext context,
    String title,
    Gender value,
    Gender? groupValue,
    void Function(Gender?) handleChange,
  ) {
    return Row(children: [
      _buildOption(context, value, groupValue, handleChange),
      GestureDetector(
          onTap: () => handleChange(value),
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: UdiColors.greyishBrown)))
    ]);
  }

  /// 建立 Radio 物件
  Radio<Gender> _buildOption(
    BuildContext context,
    Gender value,
    Gender? groupValue,
    void Function(Gender?) handleChange,
  ) {
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
  Padding _buildPhoneTile(
    BuildContext context,
    String? area,
    String? phone,
    String? ext,
    void Function(String?) handleChange,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 104.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildPingFangTCSemiboldText('市話'),
              const SizedBox(height: 8.0),
              Row(children: [
                SizedBox(
                    width: 90.0,
                    child: _buildHighlightTextField('區碼', handleChange)),
                const SizedBox(width: 10.0),
                Expanded(child: _buildHighlightTextField('市內電話', handleChange)),
                const SizedBox(width: 10.0),
                SizedBox(
                    width: 119.0,
                    child: _buildHighlightTextField('分機', handleChange))
              ]),
              const SizedBox(height: 3.0),
              _buildErrorMessage(context, '請輸入有效市話')
            ])));
  }

  /// 建立地址輸入框
  Padding _buildAddressTile(
    BuildContext context,
    String? zipCode,
    String? county,
    String? district,
    String? address,
    void Function(String?) handleChange,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 149.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildPingFangTCSemiboldText('地址'),
              const SizedBox(height: 8.0),
              Row(children: [
                Expanded(child: _buildHighlightTextField('郵遞區號', handleChange)),
                const SizedBox(width: 10.0),
                Expanded(child: _buildDropdownTextField('縣市')),
                const SizedBox(width: 10.0),
                Expanded(child: _buildDropdownTextField('鄉鎮市區'))
              ]),
              const SizedBox(height: 8.0),
              _buildHighlightTextField('請輸入街號、樓層', handleChange),
              const SizedBox(height: 3.0),
              _buildErrorMessage(context, '請輸入有效地址')
            ])));
  }

  /// 建立驗證碼輸入匡
  Padding _buildValidationCodeTile(
    BuildContext context,
    String? code,
    void Function(String)? handleChange,
    void Function(String?) handlePressed,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
            width: double.infinity,
            height: 104.0,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                    child: TextField(
                        onChanged: handleChange,
                        cursorColor: UdiColors.brownGrey2,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            border: _buildHighlightBorder(),
                            enabledBorder: _buildHighlightBorder(),
                            focusedBorder: _buildHighlightBorder(),
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
                            primary:
                                Theme.of(context).appBarTheme.backgroundColor),
                        onPressed: () => handlePressed(_validationCode),
                        child: const Text('提交')))
              ]),
              const SizedBox(height: 4.0),
              Text('請耐心等候驗證簡訊，約300秒後可重新發送。',
                  style: _buildPingFangTCRegularStyle(UdiColors.brownGrey2,
                      fontSize: 12.0))
            ])));
  }

  /// 建立行動電話顯示
  Padding _buildMobileTile(
    BuildContext context,
    String sensitiveMobile,
    bool isValidation,
    void Function(String?) handleValidCodeSend,
    void Function(String?) handleMobileChange,
  ) {
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
                            ? [
                                _buildHyperLinkButton(
                                    context, '手機變更', true, handleMobileChange)
                              ]
                            : [
                                _buildHyperLinkButton(
                                    context,
                                    '發送驗證碼',
                                    _showValidationView == false,
                                    handleValidCodeSend),
                                const SizedBox(width: 4),
                                _buildHyperLinkButton(
                                    context, '手機變更', true, handleMobileChange)
                              ])
                  ])
            ])));
  }

  /// 建立Email顯示
  Padding _buildEmailTile(
    BuildContext context,
    MemberProfileController controller,
    String email,
    bool isValidation,
    void Function(String?) handleTap,
  ) {
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
                            ? [
                                _buildHyperLinkButton(
                                    context, 'Email變更', true, handleTap)
                              ]
                            : [
                                _buildHyperLinkButton(
                                    context, '發送驗證信', true, handleTap),
                                const SizedBox(width: 4),
                                _buildHyperLinkButton(
                                    context, 'Email變更', true, handleTap)
                              ])
                  ])
            ])));
  }

  /// 超連結樣式按鈕
  GestureDetector _buildHyperLinkButton(
    BuildContext context,
    String text,
    bool enable,
    void Function(String?) handleTap,
  ) {
    return GestureDetector(
      child: _buildHyperLinkText(context, text, active: enable),
      onTap: () => enable ? handleTap(text) : null,
    );
  }

  /// 建立行動電話輸入框
  Padding _buildMobileInputTile(
    BuildContext context,
    String? mobile,
    bool isValidCountryCode,
    bool isValidMobile,
    void Function(String?) handleCountryCodeChange,
    void Function(String?) handleChange,
  ) {
    bool isValid = isValidCountryCode && isValidMobile;
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: isValid ? 80.0 : 104.0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: isValid
                ? [
                    _buildRequiresText(context, '手機'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        SizedBox(
                            width: 84.0,
                            child: _buildHighlightTextField(
                                '', handleCountryCodeChange)),
                        const SizedBox(width: 10.0),
                        Expanded(
                            child: _buildHighlightTextField(
                                '請輸入手機號碼', handleChange))
                      ],
                    ),
                  ]
                : [
                    _buildRequiresText(context, '手機'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        SizedBox(
                            width: 84.0,
                            child: _buildHighlightTextField(
                                '', handleCountryCodeChange)),
                        const SizedBox(width: 10.0),
                        Expanded(
                            child: _buildHighlightTextField(
                                '請輸入手機號碼', handleChange))
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
  Padding _buildInputTile(
    BuildContext context,
    String title,
    String? text,
    String hintText,
    String errorText,
    bool isValid,
    void Function(String?) handleChange,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: SizedBox(
          width: double.infinity,
          height: isValid ? 80.0 : 104.0,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: isValid
                  ? [
                      _buildRequiresText(context, title),
                      const SizedBox(height: 8.0),
                      _buildHighlightTextField(hintText, handleChange),
                    ]
                  : [
                      _buildRequiresText(context, title),
                      const SizedBox(height: 8.0),
                      _buildHighlightTextField(hintText, handleChange),
                      const SizedBox(height: 3.0),
                      _buildErrorMessage(context, errorText)
                    ]),
        ));
  }

  /// 建立左邊有icon的錯誤訊息
  Row _buildErrorMessage(
    BuildContext context,
    String message,
  ) {
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
  GestureDetector _buildDropdownTextField(String hintText) {
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
                  border: _buildHighlightBorder(),
                  enabledBorder: _buildHighlightBorder(),
                  focusedBorder: _buildHighlightBorder(),
                  disabledBorder: _buildHighlightBorder(),
                  hintText: hintText,
                  hintStyle: const TextStyle(color: UdiColors.brownGrey2),
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
  TextField _buildHighlightTextField(
      String hintText, void Function(String?) handleChange,
      {bool isHighlight = false}) {
    return TextField(
        onChanged: handleChange,
        cursorColor: UdiColors.brownGrey2,
        decoration: InputDecoration(
            isCollapsed: true,
            border: _buildHighlightBorder(isHighlight: isHighlight),
            enabledBorder: _buildHighlightBorder(isHighlight: isHighlight),
            focusedBorder: _buildHighlightBorder(isHighlight: isHighlight),
            hintText: hintText,
            hintStyle: const TextStyle(color: UdiColors.brownGrey2),
            contentPadding: const EdgeInsets.only(
              left: 10.0,
              top: 40.0 / 4,
              bottom: 40.0 / 4,
            )));
  }

  /// 建立有狀態的邊匡
  OutlineInputBorder _buildHighlightBorder({bool isHighlight = false}) {
    return OutlineInputBorder(
        borderSide: BorderSide(
            width: 1.0,
            color:
                isHighlight ? UdiColors.strawberry : UdiColors.veryLightGrey2));
  }

  /// 建立有星號(*)的文字
  RichText _buildRequiresText(
    BuildContext context,
    String text,
  ) {
    return RichText(
      text: TextSpan(
          text: text,
          style: _buildPingFangTCSemiboldStyle(),
          children: <TextSpan>[
            TextSpan(
                text: "*",
                style:
                    _buildPingFangTCSemiboldStyle(color: UdiColors.strawberry))
          ]),
    );
  }

  /// 建立粗體字體
  Text _buildPingFangTCSemiboldText(String text) {
    return Text(text, style: _buildPingFangTCSemiboldStyle());
  }

  /// 建立粗體字樣式
  TextStyle _buildPingFangTCSemiboldStyle(
      {Color color = UdiColors.greyishBrown}) {
    return TextStyle(
        color: color,
        fontFamily: 'PingFangTC Semibold',
        fontWeight: FontWeight.w600,
        fontSize: 14.0);
  }

  /// 建立一般字體
  Text _buildPingFangTCRegularText(String text,
      {Color color = UdiColors.greyishBrown}) {
    return Text(text, style: _buildPingFangTCRegularStyle(color));
  }

  /// 建立一般字樣式
  TextStyle _buildPingFangTCRegularStyle(Color color,
      {double fontSize = 14.0}) {
    return TextStyle(
        color: color,
        fontFamily: 'PingFangTC Regular',
        fontWeight: FontWeight.w400,
        fontSize: fontSize);
  }

  /// 建立驗證結果文字
  Text _buildValidResultText(bool isValid) {
    return Text(isValid ? '已驗證' : '未驗證',
        style: _buildValidResultStyle(
            isValid ? UdiColors.green : UdiColors.strawberry));
  }

  TextStyle _buildValidResultStyle(Color color) {
    return _buildPingFangTCRegularStyle(color, fontSize: 12.0);
  }

  /// 建立超連結文字
  Text _buildHyperLinkText(BuildContext context, String text,
      {bool active = true}) {
    return Text(text,
        style: TextStyle(
            color: active
                ? Theme.of(context).appBarTheme.backgroundColor
                : UdiColors.brownGrey2,
            fontFamily: 'PingFangTC Regular',
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
            decoration: TextDecoration.underline));
  }
}
