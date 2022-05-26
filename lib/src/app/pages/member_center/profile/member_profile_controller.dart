import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';
import 'member_profile_presenter.dart';

class MemberProfileController extends Controller {
  MemberProfile? _memberProfile;
  MemberProfile? get memberProfile => _memberProfile;

  final MemberProfilePresenter memberProfilePresenter;

  final MemberVerificationPresenter memberVerificationPresenter;

  MemberProfileController(
    memberProfileRepo,
    memberVerificationRepo,
  )   : memberProfilePresenter = MemberProfilePresenter(memberProfileRepo),
        memberVerificationPresenter =
            MemberVerificationPresenter(memberVerificationRepo),
        super();

  @override
  void onInitState() {
    getMemberProfile();
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    /// The 'Controller' will specify what listeners the 'Presenter'
    /// should call for all success and error events as mentioned
    /// previously.
    memberProfilePresenter.getMemberProfileOnNext =
        (MemberProfile memberProfile) {
      debugPrint(memberProfile.toString());
      _memberProfile = memberProfile;

      /// The 'Controller' has access to the 'ViewState' and can refresh
      /// the 'ControllerWidgets' via 'refreshUI()'.
      refreshUI();
    };

    memberProfilePresenter.getMemberProfileOnComplete = () {
      debugPrint('Member profile retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    memberProfilePresenter.getMemberProfileOnError = (e) {
      debugPrint('Could not retrieve member profile.');
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));

      _memberProfile = null;

      refreshUI();
    };
  }

  @override
  void onResumed() => debugPrint('On resumed');

  @override
  void onReassembled() => debugPrint('View is about to be ressembled');

  @override
  void onDeactivated() => debugPrint('View is about to be deactivated');

  @override
  void onDisposed() {
    // don't forget to dispose of the presenter
    memberProfilePresenter.dispose();
    super.onDisposed();
  }

  void getMemberProfile() => memberProfilePresenter.getMemberProfile();

  void verifyMobile(
    String countryCode,
    String mobile,
  ) =>
      memberVerificationPresenter.verifyMobile(
        countryCode,
        mobile,
      );

  void updateName(String? name) {
    if (name != null && name.isNotEmpty && _memberProfile?.name != name) {
      _memberProfile?.name = name;
      refreshUI();
    }
  }

  bool validateName(String? name) {
    return name == null || !(name.contains('!'));
  }

  void updateEmail(String? email) {
    if (_memberProfile?.email != email) {
      _memberProfile?.email = email;
      refreshUI();
    }
  }

  bool validateEmail(String? email) {
    var regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    bool result = email == null || email.isEmpty || email.startsWith(regex);
    debugPrint('Email is ${result ? 'valid' : 'invalid'} ');
    return result;
  }

  void updateCountryCode(String? code) {
    if (code != null &&
        code.isNotEmpty &&
        _memberProfile?.countryCode != code) {
      _memberProfile?.countryCode = code;
      refreshUI();
    }
  }

  bool validateCountryCode(String? code) {
    var regex = RegExp('^[0-9]{3}\$');
    return code == null || code.startsWith(regex);
  }

  void updateMobile(String? mobile) {
    if (mobile != null &&
        mobile.isNotEmpty &&
        _memberProfile?.mobile != mobile) {
      _memberProfile?.mobile = mobile;
      refreshUI();
    }
  }

  bool validateMobile(String? mobile) {
    var regex = RegExp('^09[0-9]{8}\$');
    return mobile == null || mobile.startsWith(regex);
  }

  void updatePhone(String? phone) {
    if (_memberProfile?.mobile != phone) {
      _memberProfile?.phone = phone;
      refreshUI();
    }
  }

  void updateArea(String? area) {
    if (_memberProfile?.areaCode != area) {
      _memberProfile?.areaCode = area;
      refreshUI();
    }
  }

  void updateExt(String? ext) {
    if (_memberProfile?.ext != ext) {
      _memberProfile?.ext = ext;
      refreshUI();
    }
  }

  bool validatePhone(String area, String phone, String ext) {
    /// 區碼跟電話有資料
    /// 區碼需 2 到 3 個字
    /// 電話需 5 到 8 個字
    bool validateLength(String area, String phone) {
      return area.isNotEmpty &&
          area.length > 1 &&
          area.length < 4 &&
          phone.isNotEmpty &&
          phone.length > 4 &&
          phone.length < 9;
    }

    return validateLength(area, phone)

        /// 區碼、電話跟分機都空白
        ||
        area.isEmpty && phone.isEmpty && ext.isEmpty

        /// 區碼、電話跟分機都有資料
        ||
        validateLength(area, phone) && ext.isNotEmpty;
  }
}
