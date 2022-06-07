import 'package:brandstores/src/app/widgets/udi_style/udi_button.dart';
import 'package:brandstores/src/app/widgets/udi_style/error_text.dart';
import 'package:brandstores/src/data/repositories/data_account_repository.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/enum/verify_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:pinput/pinput.dart';

import 'otp_controller.dart';

class OtpPage extends View {
  OtpPage(this.verifyType, this.mobile, {Key? key, this.mobileCode = '886'}) : super(key: key);
  final VerifyType verifyType;
  final String mobileCode;
  final String mobile;

  String getMobileCode() => mobileCode.replaceAllMapped(RegExp(r'\+?(\d{3})'), (match) {
        return '${match.group(1)}';
      });

  @override
  _PageState createState() => _PageState();
}

class _PageState extends ViewState<OtpPage, OtpController> {
  _PageState() : super(OtpController(DataAccountRepository()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget get view => Scaffold(
      key: globalKey,
      appBar: AppBar(title: const Text('手機驗證')),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
          child: Form(
              key: _formKey,
              child: ControlledWidgetBuilder<OtpController>(
                  builder: (context, controller) => _viewBody(controller)))));

  String getDisplayMobile() {
    var mobile = widget.mobile.replaceAllMapped(RegExp(r'(\d{4})(\d{3})(\d{3})'), (match) {
      return '${match.group(1)}-${match.group(2)}-${match.group(3)}';
    });
    return '+${widget.getMobileCode()} $mobile';
  }

  Column _viewBody(OtpController controller) {
    return Column(
      children: [
        const Text('我們將會發送驗證碼至',
            style: TextStyle(
              color: UdiColors.secondaryText,
              fontWeight: FontWeight.normal,
            )),
        const SizedBox(height: 9),
        Text(
          getDisplayMobile(),
          style: const TextStyle(color: UdiColors.normalText, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        buildPinPut(controller),
        const SizedBox(height: 12),
        ErrorText(controller.apiErrorMessage),
        const SizedBox(height: 12),
        _submitButton(controller),
      ],
    );
  }

  Pinput buildPinPut(OtpController controller) => Pinput(
      onChanged: (pin) => setState(() => controller.inputOtp = pin),
      defaultPinTheme: const PinTheme(
          width: 56,
          height: 56,
          textStyle:
              TextStyle(fontSize: 40, color: UdiColors.normalText, fontWeight: FontWeight.bold),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: UdiColors.defaultBorder, width: 2)),
          )));

  SizedBox _submitButton(OtpController controller) => SizedBox(
      width: double.infinity,
      child: UdiButton(
        text: '確定',
        onPressed: controller.inputOtp.length == 4
            ? () => controller.verifyOtp(widget.verifyType, widget.getMobileCode(), widget.mobile)
            : null,
      ));
}
