/// Represents only the UI of the page. The 'View' builds the page's UI,
/// styles it, and depends on the 'Controller' to handle its events. The
/// 'View' has-a 'Controller'.
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/login_state.dart';

import 'member_center_controller.dart';

import 'package:brandstores/src/data/repositories/member/data_member_center_repository.dart';

import 'package:brandstores/src/domain/entities/link.dart';
import 'package:brandstores/src/domain/entities/member/member_center.dart';

import 'package:brandstores/src/app/widgets/member/center/member_card.dart';
import 'package:brandstores/src/app/widgets/member/center/member_level_card.dart';
import 'package:brandstores/src/app/widgets/member/center/services_card.dart';
import 'package:brandstores/src/app/widgets/member/center/horizontal_product_list_card.dart';
import 'package:brandstores/src/app/widgets/member/center/banner_card.dart';
import 'package:brandstores/src/app/widgets/member/center/level_upgrade_message_card.dart';

/// In the case of Flutter
/// - The 'View' is comprised of 2 classes
///   * One that extends 'View', which would be the root 'Widget'
///     representing the 'View'
///   * One that extends 'ViewState' with the template specialization
///     of the other class and its 'Controller'.
/// - The 'StatefulWidget' only serves to pass arguments to the 'State'
///   from other pages such as a title etc.. it only insatatiates the 'State'
///   object (the 'ViewState') and provides it with the 'Controller' it
///   needs through it's consumer.
/// - In summary, both the 'StatefulWidget' and the 'State' are
///   represented by a 'View' and 'ViewState' of the page.
class MemberCenterPage extends View {
  MemberCenterPage({Key? key, this.title}) : super(key: key);

  final String? title;

  /// - 'StatefulWidget' contains the 'State' as per 'Flutter'
  /// - The 'StatefulWidtet' has-a 'State' object (the 'ViewStat') which
  ///   has-a 'Controller'
  @override
  _MemberCenterPageState createState() =>
      // inject dependencies inwards
      _MemberCenterPageState();
}

/// - The 'ViewState' class maintains a 'GlobalKey' that can be used
///   as a key in its scaffold. If used, the 'Controller' can easily access
///   it via 'getState()' in order to show snackbars and other dialogs.
///   This is helpful but optional.
class _MemberCenterPageState
    extends ViewState<MemberCenterPage, MemberCenterController> {
  _MemberCenterPageState()
      : super(MemberCenterController(DataMemberCenterRepository()));

  void openLevelDescriptionPage(List<LevelSetting> levelSettings) {
    context.pushNamed(memberLevelInfoRouteName, extra: levelSettings);
  }

  void openLoginPage() {
    context.pushNamed(loginRouteName);
  }

  void openMemberUpdatePage() {
    context.pushNamed(memberProfileRouteName);
  }

  void openServicePage(BuildContext context, Service service) {
    if (service.linkType == LinkType.service) {
      context.pushNamed(serviceRouteName);
    } else if (Provider.of<LoginState>(context, listen: false).loggedIn ==
        false) {
      openLoginPage();
    } else {
      switch (service.linkType) {
        case LinkType.bought:
          context.pushNamed(boughtProductsRouteName);
          break;
        case LinkType.cookie:
          context.pushNamed(browseProductsRouteName);
          break;
        case LinkType.updatemember:
          context.pushNamed(memberProfileRouteName);
          break;
        case LinkType.fastcheckout:
          context.pushNamed(checkoutSettingRouteName);
          break;
        default:
          break;
      }
    }
  }

  /// - The 'ViewState' contains the 'view' getter, which is technically
  ///   the UI implementaion
  @override
  Widget get view {
    return ControlledWidgetBuilder<MemberCenterController>(
        builder: (context, controller) {
      final ThemeData theme = Theme.of(context);

      /// ?????????????????????????????????
      if (Provider.of<LoginState>(context, listen: false).loggedIn == false &&
          controller.memberCenter?.member != null) {
        controller.clearMember();
      }

      /// ??????????????????????????????
      if (Provider.of<LoginState>(context, listen: false).loggedIn == true &&
          controller.memberCenter?.member == null) {
        controller.getMemberCenter();
      }

      return Scaffold(
          body: Stack(children: [
        Background(theme: theme),
        ListView(children: _buildCardList(context, controller)),
      ]));
    });
  }

  List<Widget> _buildCardList(
      BuildContext context, MemberCenterController controller) {
    List<Widget> children = [];

    if (controller.memberCenter?.member == null ||
        controller.memberCenter?.member?.online == "NO") {
      children.add(MemberCard(
        member: controller.memberCenter?.member,
        loginButtonTapped: openLoginPage,
        avatarTapped: openMemberUpdatePage,
      ));
    } else {
      children.addAll([
        MemberLevelCard(
          member: controller.memberCenter!.member!,
          levelDescriptionButtonTapped: openLevelDescriptionPage,
          avatarTapped: openMemberUpdatePage,
        ),
        LevelUpgradeMessageCard(
            message: controller.memberCenter!.member!.nextLevelDescription)
      ]);
    }
    if (controller.memberCenter != null) {
      children.addAll([
        ServicesCard(
          services: controller.memberCenter!.services,
          tapped: (service) => openServicePage(context, service),
        ),
        HorizontalProductListCard(productList: [
          controller.memberCenter!.newGoodsInfo,
          controller.memberCenter!.bestSellersInfo
        ]),
        BannerCard(imageUrls: _buildBannerList(controller))
      ]);
    }

    return children;
  }

  List<String> _buildBannerList(MemberCenterController controller) {
    return List.generate(controller.memberCenter!.banners.length,
        (index) => controller.memberCenter!.banners[index].image);
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: NativeClipper(),
      child: Container(
        height: 300,
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
    );
  }
}

class NativeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
