/// Every 'ViewState' has-a 'Controller'. The 'Controller' provides the
/// needed member data of the 'ViewState' i.e. dynamic data. The
/// 'Controller' also implements the event-handlers of the 'ViewState'
/// widgets, but has no access to the 'Widgets' themselves. The
/// 'ViewState' uses the 'Controller', not the other way around.
/// When the 'ViewState' calls a handler from the 'Controller',
/// 'refreshUI()' can be called to update the view.
import 'package:brandstores/src/domain/entities/member_center/member_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'member_center_presenter.dart';

/// Every 'Controller' extends the 'Controller' abstract class, which
/// implements 'WidgetBindingObserver'. Every 'Controller' class is
/// responsible for handling lifecycle events for the 'View' and can override:
///   * void onInActive()
///   * void onPaused()
///   * void onResumed()
///   * void onDetached()
///   * void onDisposed()
///   * void onReassembled()
///   * void onDidChangeDependencies()
///   * void onInitState()
///   * etc..
class MemberCenterController extends Controller {
  MemberCenter? _memberCenter;
  MemberCenter? get memberCenter => _memberCenter; // data used by the View

  /// The 'Controller' has-a 'Presenter'. The 'Controller' will pass the
  /// 'Repository' to the 'Presenter', which it communicate later with the
  /// 'Usecase'. Only the 'Controller' is allowed to obtain instances of a 'Repository'
  /// from the 'Data' or 'Device' module in the outermost layer.
  final MemberCenterPresenter memberCenterPresenter;
  // Presenter should always be initialized this way
  MemberCenterController(memberCenterRepository)
      : memberCenterPresenter = MemberCenterPresenter(memberCenterRepository),
        super();

  @override
  void onInitState() {
    getMemberCenter();
  }

  /// Also, ervery 'Controller' has to implement initListeners() that
  /// initializes the listeners for the 'Presenter' for consistency.
  @override
  // this is called automatically by the parent class
  void initListeners() {
    /// The 'Controller' will specify what listeners the 'Presenter'
    /// should call for all success and error events as mentioned
    /// previously.
    memberCenterPresenter.getMemberCenterOnNext = (MemberCenter memberCenter) {
      debugPrint(memberCenter.toString());
      _memberCenter = memberCenter;

      /// The 'Controller' has access to the 'ViewState' and can refresh
      /// the 'ControllerWidgets' via 'refreshUI()'.
      refreshUI();
    };

    memberCenterPresenter.getMemberCenterOnComplete = () {
      debugPrint('Member center retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    memberCenterPresenter.getMemberCenterOnError = (e) {
      debugPrint('Could not retrieve member center.');
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));

      _memberCenter = null;

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
    memberCenterPresenter.dispose();
    super.onDisposed();
  }

  void getMemberCenter() => memberCenterPresenter.getMemberCenter();

  void getUserWithError() => memberCenterPresenter.getMemberCenter();

  void buttonPressed() {
    refreshUI();
  }
}
