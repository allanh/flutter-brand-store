import 'package:brandstores/src/app/pages/member_center/account_change/account_change_view.dart';
import 'package:brandstores/src/app/pages/member_center/profile/member_profile_controller.dart';
import 'package:brandstores/src/app/widgets/member_center/account_change/result_description_view.dart';
import 'package:brandstores/src/data/repositories/data_member_profile_repository.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';

import 'package:intl/intl.dart';

import 'package:brandstores/src/app/widgets/member_center/member_profile/common.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/birthday_change_hint_tile.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/address_tile.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/phone_tile.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/gender_tile.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/birthday_tile.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/password_setting_tile.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/profile_save_button.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/binding_hint_tile.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/binding_tile.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/mobile_tile.dart';
import 'package:brandstores/src/app/widgets/member_center/member_profile/email_tile.dart';

class MemberProfilePage extends View {
  MemberProfilePage({Key? key}) : super(key: key);

  @override
  State<MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState
    extends ViewState<MemberProfilePage, MemberProfileController> {
  _MemberProfilePageState()
      : super(MemberProfileController(DataMemberProfileRepository()));

  String? _validationCode;

  bool _showValidationView = false;

  @override
  Widget get view {
    return Scaffold(
        appBar: AppBar(title: const Text('會員資料')),
        body: ControlledWidgetBuilder<MemberProfileController>(
            builder: (context, controller) {
          final MemberProfile? profile = controller.memberProfile;

          void handleCountryCodeChange(code) {
            controller.updateCountryCode(code);
          }

          void handleMobileChange(mobile) {
            controller.updateMobile(mobile);
          }

          void handleSendValidationCode(code) {
            controller.verifyMobile(
              profile?.countryCode ?? '886',
              profile?.mobile ?? '',
            );
            setState(() {
              _showValidationView = true;
            });
          }

          void handleChangeMobile(message) {
            debugPrint(message);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AccountChangePage(type: AccountType.mobile),
                  fullscreenDialog: true,
                ));
          }

          void handleValidationCodeChange(code) {
            _validationCode = code;
          }

          void handleValidationCodeSubmit(code) {
            setState(() {
              if (code != null && code.isEmpty == false) {
                _showValidationView = false;
                _validationCode = null;
              }
            });
          }

          void handleNameChange(name) {
            controller.updateName(name);
          }

          void handleEmailChange(email) {
            controller.updateEmail(email);
          }

          void handleChangeEmail(toggle) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AccountChangePage(type: AccountType.email),
                  fullscreenDialog: true,
                ));
          }

          void handleSendValidationMail(toggle) {}

          void handleAreaChange(area) {
            controller.updateArea(area);
          }

          void handlePhoneChange(phone) {
            controller.updatePhone(phone);
          }

          void handleExtChange(ext) {
            controller.updateExt(ext);
          }

          void handleGenderChange(gender) {
            controller.updateGender(gender);
          }

          void handleBirthdayChange(birthday) {
            final DateFormat formatter = DateFormat('yyyy/MM/dd');
            birthday = formatter.format(birthday);
            controller.updateBirthday(birthday);
          }

          void handleCountyChange(BuildContext context, String county) {
            controller.updateCounty(context);
          }

          void handleDistrictChange(BuildContext context, String county) {
            controller.updateDistrict(context, county);
          }

          void handleAddressChange(String? address) {
            controller.updateAddress(address);
          }

          void handleUpdateData() {
            controller.updateProfile();
          }

          void handleBinding(String name, Binding? binding) {
            if (binding?.bindingId == null) {
              controller.handleBinding(name);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: const Text('綁定帳號'),
                      automaticallyImplyLeading: false,
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    body: ResultDescriptionView(
                      context: context,
                      image: 'assets/images/icon_completed_stroke.png',
                      description: '已完成綁定！\n下次登入時可使用$name帳號快速登入！',
                      completedButton: Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0),
                        child: SizedBox(
                            height: 36.0,
                            width:
                                MediaQuery.of(context).size.width - 24.0 - 24.0,
                            child: ElevatedButton(
                              child: const Text('確定'),
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor),
                              onPressed: () => Navigator.pop(context),
                            )),
                      ),
                    ),
                  ),
                  fullscreenDialog: true,
                ),
              );
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  contentPadding:
                      const EdgeInsets.fromLTRB(24.0, 66.0, 24.0, 36.0),
                  actionsPadding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  content: Text('確定要解除綁定？',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: UdiColors.greyishBrown)),
                  actions: <Widget>[
                    SizedBox(
                      width: 117.0,
                      height: 36.0,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, '取消'),
                        child: const Text('取消'),
                        style: OutlinedButton.styleFrom(
                            primary:
                                Theme.of(context).appBarTheme.backgroundColor),
                      ),
                    ),
                    SizedBox(
                      width: 117.0,
                      height: 36.0,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.handleUnbinding(name);
                            Navigator.pop(context, '確定');
                          },
                          child: const Text('確定'),
                          style: ElevatedButton.styleFrom(
                            primary:
                                Theme.of(context).appBarTheme.backgroundColor,
                          )),
                    ),
                  ],
                ),
              );
            }
          }

          List<Widget> list = [
            /// 生日修改次數說明
            BirthdayChangeHintTile(context: context),

            /// 姓名區塊
            InputTile(
                context: context,
                title: '姓名',
                text: profile?.name,
                hintText: '請輸入姓名',
                errorText: '請輸入有效姓名',
                isValid: controller.validateName(profile?.name),
                handleChange: handleNameChange),

            /// 行動電話區塊
            MobileTile(
                showValidationView: _showValidationView,
                validationCode: _validationCode,
                context: context,
                countryCode: profile?.countryCode,
                mobile:
                    profile?.mobile != null ? profile?.sensitiveMobile : null,
                isVerify: profile?.isVerifyMobile,
                isValidCountryCode:
                    controller.validateCountryCode(profile?.countryCode),
                isValidMobile: controller.validateMobile(profile?.mobile),
                handleCountryCodeChange: handleCountryCodeChange,
                handleMobileChange: handleMobileChange,
                handleSendValidationCode: handleSendValidationCode,
                handleChangeMobile: handleChangeMobile,
                handleValidationCodeChange: handleValidationCodeChange,
                handleValidationCodeSubmit: handleValidationCodeSubmit),

            /// Eamil 區塊
            EmailTile(
              context: context,
              email: profile?.email,
              isVerify: profile?.isVerifyEmail ?? false,
              isValid: controller.validateEmail(profile?.email),
              handleEmailChange: handleEmailChange,
              handleSendValidationMail: handleSendValidationMail,
              handleChangeEmail: handleChangeEmail,
            ),

            /// 市話區塊
            PhoneTile(
              context: context,
              area: profile?.areaCode,
              phone: profile?.phone,
              ext: profile?.ext,
              isValid: controller.validatePhone(profile?.areaCode ?? '',
                  profile?.phone ?? '', profile?.ext ?? ''),
              handleAreaChange: handleAreaChange,
              handlePhoneChange: handlePhoneChange,
              handleExtChange: handleExtChange,
            ),

            /// 性別區塊
            GenderTile(
                context: context,
                gender: profile?.gender,
                handleGender: handleGenderChange),

            /// 生日區塊
            BrithdayTile(
                context: context,
                enableChange: profile?.enableBirthdayChange ?? false,
                birthday: profile?.birthday,
                handleConfirm: handleBirthdayChange),

            /// 地址
            AddressTile(
              context: context,
              zipCode: profile?.zipCode,
              county: profile?.county,
              district: profile?.district,
              address: profile?.address,
              isValid: controller.validateAddress(profile?.zipCode,
                  profile?.county, profile?.district, profile?.address),
              handleCountyChange: () =>
                  handleCountyChange(context, profile?.county ?? ''),
              handleDistrictChange: () => {
                if (profile?.county != null)
                  {
                    handleDistrictChange(context, profile!.county!),
                  }
              },
              handleAddressChange: handleAddressChange,
            ),

            /// 密碼設定
            PasswordSettingTile(
                context: context,
                isSettingPassword: profile?.isSettingPassword ?? false,
                handleTap: (message) {
                  debugPrint(message);
                }),

            /// 儲存按鈕
            SaveButton(context: context, handleSave: handleUpdateData),

            /// 分隔線
            const Divider(
                thickness: 1.0,
                indent: 12.0,
                endIndent: 12.0,
                color: UdiColors.veryLightGrey2),

            /// 綁定帳號提示
            BindingHintTile(context: context),

            /// Facebook帳號綁定
            BindingTile(
                context: context,
                binding: profile?.bindingInfo?.facebookBinding,
                image: profile?.bindingInfo?.facebookBindingImage ??
                    'assets/images/icon_circle_facebook.png',
                isBinding:
                    profile?.bindingInfo?.facebookBinding?.bindingId != null,
                handleBinding: (binding) => handleBinding(
                    'Facebook', profile?.bindingInfo?.facebookBinding)),

            /// Google帳號綁定
            BindingTile(
                context: context,
                binding: profile?.bindingInfo?.googleBinding,
                image: profile?.bindingInfo?.googleBindingImage ??
                    'assets/images/icon_circle_google.png',
                isBinding:
                    profile?.bindingInfo?.googleBinding?.bindingId != null,
                handleBinding: (binding) => handleBinding(
                    'Google', profile?.bindingInfo?.googleBinding)),

            /// Line帳號綁定
            BindingTile(
                context: context,
                binding: profile?.bindingInfo?.lineBinding,
                image: profile?.bindingInfo?.lineBindingImage ??
                    'assets/images/icon_circle_line.png',
                isBinding: profile?.bindingInfo?.lineBinding?.bindingId != null,
                handleBinding: (binding) =>
                    handleBinding('Line', profile?.bindingInfo?.lineBinding)),

            /// Apple帳號綁定
            BindingTile(
                context: context,
                binding: profile?.bindingInfo?.appleBinding,
                image: profile?.bindingInfo?.appleBindingImage ??
                    'assets/images/icon_circle_apple.png',
                isBinding:
                    profile?.bindingInfo?.appleBinding?.bindingId != null,
                handleBinding: (binding) =>
                    handleBinding('Apple', profile?.bindingInfo?.appleBinding)),
          ];

          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return list[index];
              });
        }));
  }
}
