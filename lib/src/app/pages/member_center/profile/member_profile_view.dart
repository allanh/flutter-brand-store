import 'package:brandstores/src/app/pages/member_center/profile/member_profile_controller.dart';
import 'package:brandstores/src/data/repositories/data_member_profile_repository.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';

import 'package:intl/intl.dart';

import 'package:brandstores/src/app/widgets/member_profile/common.dart';
import 'package:brandstores/src/app/widgets/member_profile/birthday_change_hint_tile.dart';
import 'package:brandstores/src/app/widgets/member_profile/address_tile.dart';
import 'package:brandstores/src/app/widgets/member_profile/phone_tile.dart';
import 'package:brandstores/src/app/widgets/member_profile/gender_tile.dart';
import 'package:brandstores/src/app/widgets/member_profile/birthday_tile.dart';
import 'package:brandstores/src/app/widgets/member_profile/password_setting_tile.dart';
import 'package:brandstores/src/app/widgets/member_profile/profile_save_button.dart';
import 'package:brandstores/src/app/widgets/member_profile/binding_hint_tile.dart';
import 'package:brandstores/src/app/widgets/member_profile/binding_tile.dart';
import 'package:brandstores/src/app/widgets/member_profile/mobile_tile.dart';
import 'package:brandstores/src/app/widgets/member_profile/email_tile.dart';

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
          // final List<Districts>? districts = controller.districts;
          // debugPrint(districts.toString());

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

          void handleChangeEmail(toggle) {}

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

          void handleZipCodeChange(zipCode) {}
          void handleCountyChange(BuildContext context) {
            controller.updateCounty(context);
          }

          void handleDistrictChange(BuildContext context, String county) {
            controller.updateDistrict(context, county);
          }

          void handleAddressChange(address) {}

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
              area: profile?.district,
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
              isValid: controller.validateAddress(
                  profile?.zipCode ?? '',
                  profile?.county ?? '',
                  profile?.district ?? '',
                  profile?.address ?? ''),
              handleZipCodeChange: handleZipCodeChange,
              handleCountyChange: () => handleCountyChange(context),
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
            SaveButton(
                context: context,
                handleSave: () {
                  debugPrint('save button pressed');
                }),

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
                handleBinding: (binding) {
                  debugPrint('Facebook binding button pressed');
                }),

            /// Google帳號綁定
            BindingTile(
                context: context,
                binding: profile?.bindingInfo?.googleBinding,
                image: profile?.bindingInfo?.googleBindingImage ??
                    'assets/images/icon_circle_google.png',
                isBinding:
                    profile?.bindingInfo?.googleBinding?.bindingId != null,
                handleBinding: (binding) {
                  debugPrint('Google binding button pressed');
                }),

            /// Line帳號綁定
            BindingTile(
                context: context,
                binding: profile?.bindingInfo?.lineBinding,
                image: profile?.bindingInfo?.lineBindingImage ??
                    'assets/images/icon_circle_line.png',
                isBinding: profile?.bindingInfo?.lineBinding?.bindingId != null,
                handleBinding: (binding) {
                  debugPrint('Line binding button pressed');
                }),

            /// Apple帳號綁定
            BindingTile(
                context: context,
                binding: profile?.bindingInfo?.appleBinding,
                image: profile?.bindingInfo?.appleBindingImage ??
                    'assets/images/icon_circle_apple.png',
                isBinding:
                    profile?.bindingInfo?.appleBinding?.bindingId != null,
                handleBinding: (binding) {
                  debugPrint('Apple binding button pressed');
                }),
          ];

          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return list[index];
              });
        }));
  }
}
