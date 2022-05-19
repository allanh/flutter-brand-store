import 'package:brandstores/src/app/pages/member_center/profile/member_profile_controller.dart';
import 'package:brandstores/src/data/repositories/data_member_profile_repository.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

enum Gender { male, female, other }

class MemberProfilePage extends View {
  MemberProfilePage({Key? key}) : super(key: key);

  @override
  State<MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState
    extends ViewState<MemberProfilePage, MemberProfileController> {
  _MemberProfilePageState()
      : super(MemberProfileController(DataMemberProfileRepository()));
  Gender? _character;
  @override
  Widget get view {
    return Scaffold(
        appBar: AppBar(title: const Text('會員資料')),
        body: ControlledWidgetBuilder<MemberProfileController>(
            builder: (context, controller) {
          return Column(children: [
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
            _buildGenderRadioButtons(context),
          ]);
        }));
  }

  Padding _buildGenderRadioButtons(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      return const Color.fromRGBO(204, 204, 204, 1);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: SizedBox(
          width: double.infinity,
          height: 80.0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('性別',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: UdiColors.greyishBrown)),
            Row(
              children: [
                Radio<Gender>(
                  value: Gender.male,
                  groupValue: _character,
                  activeColor: Theme.of(context).appBarTheme.backgroundColor,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  onChanged: (Gender? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                Text('男性'),
                Radio<Gender>(
                  value: Gender.female,
                  groupValue: _character,
                  activeColor: Theme.of(context).appBarTheme.backgroundColor,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  onChanged: (Gender? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                Text('女性'),
                Radio<Gender>(
                  value: Gender.other,
                  groupValue: _character,
                  activeColor: Theme.of(context).appBarTheme.backgroundColor,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  onChanged: (Gender? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                Text('不公開')
              ],
            )
          ])),
    );
  }

  Padding _buildPhoneTextField(
      BuildContext context, String? area, String? phone, String? ext) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 104.0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('市話',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: UdiColors.greyishBrown)),
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

  TextField _buildStateTextField(String? labelText, String hintText) {
    return TextField(
        cursorColor: UdiColors.brownGrey2,
        decoration: InputDecoration(
            border: _buildStateBorder(labelText != null),
            enabledBorder: _buildStateBorder(labelText != null),
            focusedBorder: _buildStateBorder(labelText != null),
            hintText: hintText,
            hintStyle: const TextStyle(color: UdiColors.brownGrey2),
            labelText: labelText,
            contentPadding: const EdgeInsets.only(
              left: 10.0,
              bottom: 36.0 / 2,
            )));
  }

  OutlineInputBorder _buildStateBorder(bool valid) {
    return OutlineInputBorder(
        borderSide: BorderSide(
            width: 1.0,
            color: valid ? UdiColors.veryLightGrey2 : UdiColors.strawberry));
  }

  RichText _buildRequiresText(BuildContext context, String text) {
    return RichText(
      text: TextSpan(
          text: text,
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: UdiColors.greyishBrown),
          children: <TextSpan>[
            TextSpan(
                text: "*",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: UdiColors.strawberry))
          ]),
    );
  }
}
