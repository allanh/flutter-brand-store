import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';
import 'member_profile_presenter.dart';

import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class MemberProfileController extends Controller {
  MemberProfile? _memberProfile;
  MemberProfile? get memberProfile => _memberProfile;

  VerificationResult? _verificationResult;
  VerificationResult? get verificationResult => _verificationResult;

  List<Districts>? _districts;
  List<Districts>? get districts => _districts;

  final MemberProfilePresenter presenter;

  MemberProfileController(
    memberProfileRepo,
  )   : presenter = MemberProfilePresenter(memberProfileRepo),
        super();

  @override
  void onInitState() {
    getMemberProfile();

    loadDistricts();
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    /// The 'Controller' will specify what listeners the 'Presenter'
    /// should call for all success and error events as mentioned
    /// previously.

    /// 取會員資料
    presenter.getMemberProfileOnNext = (MemberProfile memberProfile) {
      debugPrint(memberProfile.toString());
      _memberProfile = memberProfile;

      /// The 'Controller' has access to the 'ViewState' and can refresh
      /// the 'ControllerWidgets' via 'refreshUI()'.
      refreshUI();
    };

    presenter.getMemberProfileOnComplete = () {
      debugPrint('Member profile retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    presenter.getMemberProfileOnError = (e) {
      debugPrint('Could not retrieve member profile.');
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));

      _memberProfile = null;

      refreshUI();
    };

    /// 手機驗證
    presenter.verifyMobileOnNext = (VerificationResult verificationResult) {
      _verificationResult = verificationResult;
    };

    presenter.verifyMobileOnComplete = () {
      debugPrint('Verify mobile finish');
    };

    presenter.verifyMobileOnError = (e) {
      debugPrint('Could not verify mobile.');

      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));

      _verificationResult = null;

      refreshUI();
    };

    /// 下載郵遞區號
    presenter.loadDistrictsOnNext = (List<Districts> districts) {
      _districts = districts;
    };

    presenter.loadDistrictsOnComplete = () {
      debugPrint('Loaded districts finish.');
    };

    presenter.loadDistrictsOnError = (e) {
      debugPrint('Could not download districts: $e');

      _districts = null;
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
    presenter.dispose();
    super.onDisposed();
  }

  void getMemberProfile() => presenter.getMemberProfile();

  void verifyMobile(
    String countryCode,
    String mobile,
  ) =>
      presenter.verifyMobile(
        countryCode,
        mobile,
      );

  void loadDistricts() => presenter.loadDistricts();

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

  void updateGender(Gender? gender) {
    if (_memberProfile?.gender != gender) {
      _memberProfile?.gender = gender;
      refreshUI();
    }
  }

  void updateBirthday(String? birthday) {
    if (_memberProfile?.birthday != birthday) {
      _memberProfile?.birthday = birthday;
      refreshUI();
    }
  }

  bool validateAddress(
    String zipCode,
    String county,
    String district,
    String address,
  ) {
    return true;
  }

  void updateAddress(
    String? zipCode,
    String? county,
    String? district,
    String? address,
  ) {
    if (_memberProfile?.zipCode != zipCode) {
      _memberProfile?.zipCode = zipCode;
    }
    if (_memberProfile?.county != county) {
      _memberProfile?.county = county;
    }
    if (_memberProfile?.district != district) {
      _memberProfile?.district = district;
    }
    if (_memberProfile?.address != address) {
      _memberProfile?.address = address;
    }
  }

  void updateCounty(BuildContext context) {
    showMaterialScrollPicker<String>(
        context: context,
        showDivider: false,
        title: '請選擇縣市',
        headerColor: Theme.of(context).appBarTheme.backgroundColor,
        confirmText: '確定',
        cancelText: '取消',
        items: List.generate(
            _districts!.length, (index) => _districts![index].name),
        selectedItem: _districts![0].name,
        onChanged: (value) {
          if (_memberProfile?.county != value) {
            _memberProfile?.county = value;
            _memberProfile?.district = null;
            _memberProfile?.zipCode = null;
          }
        },
        onConfirmed: () {
          refreshUI();
        });
  }

  void updateDistrict(BuildContext context, String county) {
    final currentDistricts = _districts
        ?.where((district) => district.name == county)
        .toList()[0]
        .list;
    showMaterialScrollPicker<String>(
        context: context,
        showDivider: false,
        title: '請選擇鄉鎮市區',
        headerColor: Theme.of(context).appBarTheme.backgroundColor,
        confirmText: '確定',
        cancelText: '取消',
        items: List.generate(
            currentDistricts!.length, (index) => currentDistricts[index].name),
        selectedItem: currentDistricts[0].name,
        onChanged: (value) {
          _memberProfile?.district = value;
          _memberProfile?.zipCode = currentDistricts
              .where((district) => district.name == value)
              .toList()[0]
              .zip;
        },
        onConfirmed: () {
          refreshUI();
        });
  }
}
