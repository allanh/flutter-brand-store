import 'package:brandstores/src/app/pages/member/profile/member_profile_controller.dart';
import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/src/data/repositories/member/data_member_profile_repository.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/domain/entities/member/member_profile.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/intl.dart';

import 'package:brandstores/src/app/widgets/member/profile/common.dart';
import 'package:brandstores/src/app/widgets/member/profile/birthday_change_hint_tile.dart';
import 'package:brandstores/src/app/widgets/member/profile/address_tile.dart';
import 'package:brandstores/src/app/widgets/member/profile/phone_tile.dart';
import 'package:brandstores/src/app/widgets/member/profile/gender_tile.dart';
import 'package:brandstores/src/app/widgets/member/profile/birthday_tile.dart';
import 'package:brandstores/src/app/widgets/member/profile/password_setting_tile.dart';
import 'package:brandstores/src/app/widgets/member/profile/profile_save_button.dart';
import 'package:brandstores/src/app/widgets/member/profile/binding_hint_tile.dart';
import 'package:brandstores/src/app/widgets/member/profile/binding_tile.dart';
import 'package:brandstores/src/app/widgets/member/profile/mobile_tile.dart';
import 'package:brandstores/src/app/widgets/member/profile/email_tile.dart';

import '../../../widgets/member/dialog_wrapper.dart';
import '../../../widgets/member/profile/binding_completed_view.dart';

import '../../../utils/constants.dart';

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
        appBar: AppBar(title: const Text('????????????')),
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
            context.pushNamed(mobileAccountChangeRouteName);
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
            context.pushNamed(emailAccountChangeRouteName);
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
                  builder: (context) => BindingCompletedView(social: name),
                  fullscreenDialog: true,
                ),
              );
            } else {
              DialogWrapper().showTwoButtonsDialog(
                context: context,
                content: '????????????????????????',
                contentPadding:
                    const EdgeInsets.fromLTRB(30.0, 66.0, 30.0, 36.0),
                textAlign: TextAlign.center,
                handleCancel: () => Navigator.pop(context, '??????'),
                handleSubmit: () {
                  controller.handleUnbinding(name);
                  Navigator.pop(context, '??????');
                },
              );
            }
          }

          List<Widget> list = [
            /// ????????????????????????
            BirthdayChangeHintTile(context: context),

            /// ????????????
            InputTile(
                context: context,
                title: '??????',
                text: profile?.name,
                hintText: '???????????????',
                errorText: '?????????????????????',
                isValid: controller.validateName(profile?.name),
                handleChange: handleNameChange),

            /// ??????????????????
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

            /// Eamil ??????
            EmailTile(
              context: context,
              email: profile?.email,
              isVerify: profile?.isVerifyEmail ?? false,
              isValid: controller.validateEmail(profile?.email),
              handleEmailChange: handleEmailChange,
              handleSendValidationMail: handleSendValidationMail,
              handleChangeEmail: handleChangeEmail,
            ),

            /// ????????????
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

            /// ????????????
            GenderTile(
                context: context,
                gender: profile?.gender,
                handleGender: handleGenderChange),

            /// ????????????
            BrithdayTile(
                context: context,
                enableChange: profile?.enableBirthdayChange ?? false,
                birthday: profile?.birthday,
                handleConfirm: handleBirthdayChange),

            /// ??????
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

            /// ????????????
            PasswordSettingTile(
                context: context,
                isSettingPassword: profile?.isSettingPassword ?? false,
                handleTap: (message) {
                  debugPrint(message);
                  context.pushNamed(resetPasswordRouteName);
                }),

            /// ????????????
            SaveButton(context: context, handleSave: handleUpdateData),

            /// ?????????
            const Divider(
                thickness: 1.0,
                indent: 12.0,
                endIndent: 12.0,
                color: UdiColors.veryLightGrey2),

            /// ??????????????????
            BindingHintTile(context: context),

            /// Facebook????????????
            BindingTile(
                context: context,
                binding: profile?.bindingInfo?.facebookBinding,
                image: profile?.bindingInfo?.facebookBindingImage ??
                    'assets/images/icon_circle_facebook.png',
                isBinding:
                    profile?.bindingInfo?.facebookBinding?.bindingId != null,
                handleBinding: (binding) => handleBinding(
                    'Facebook', profile?.bindingInfo?.facebookBinding)),

            /// Google????????????
            BindingTile(
                context: context,
                binding: profile?.bindingInfo?.googleBinding,
                image: profile?.bindingInfo?.googleBindingImage ??
                    'assets/images/icon_circle_google.png',
                isBinding:
                    profile?.bindingInfo?.googleBinding?.bindingId != null,
                handleBinding: (binding) => handleBinding(
                    'Google', profile?.bindingInfo?.googleBinding)),

            /// Line????????????
            BindingTile(
                context: context,
                binding: profile?.bindingInfo?.lineBinding,
                image: profile?.bindingInfo?.lineBindingImage ??
                    'assets/images/icon_circle_line.png',
                isBinding: profile?.bindingInfo?.lineBinding?.bindingId != null,
                handleBinding: (binding) =>
                    handleBinding('Line', profile?.bindingInfo?.lineBinding)),

            /// Apple????????????
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
