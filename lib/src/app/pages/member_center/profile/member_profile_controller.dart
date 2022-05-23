import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:brandstores/src/domain/entities/member_profile/member_profile.dart';
import 'member_profile_presenter.dart';

class MemberProfileController extends Controller {
  MemberProfile? _memberProfile;
  MemberProfile? get memberProfile => _memberProfile;

  final MemberProfilePresenter memberProfilePresenter;

  MemberProfileController(memberProfileRepo)
      : memberProfilePresenter = MemberProfilePresenter(memberProfileRepo),
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

  bool validateName(String? name) {
    return name != null;
  }
}
