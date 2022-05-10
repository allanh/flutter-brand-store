/// Represents only the UI of the page. The 'View' builds the page's UI,
/// styles it, and depends on the 'Controller' to handle its events. The
/// 'View' has-a 'Controller'.

import 'package:brandstores/src/data/repositories/data_member_center_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'member_center_controller.dart';
import 'package:brandstores/src/app/widgets/member_center/member_card.dart';
import 'package:brandstores/src/app/widgets/member_center/member_level_card.dart';
import 'package:brandstores/src/app/widgets/member_center/services_card.dart';
import 'package:brandstores/src/app/widgets/member_center/horizontal_product_list_card.dart';
import 'package:brandstores/src/app/widgets/member_center/banner_card.dart';

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

  /// - The 'ViewState' contains the 'view' getter, which is technically
  ///   the UI implementaion
  @override
  Widget get view {
    return ControlledWidgetBuilder<MemberCenterController>(
        builder: (context, controller) {
      if (controller.memberCenter != null) {
        return Scaffold(
            key: globalKey,
            body: ListView(
              children: [
                MemberCard(member: controller.memberCenter!.member),
                MemberLevelCard(member: controller.memberCenter!.member!),
                ServicesCard(
                  services: controller.memberCenter!.services,
                ),
                HorizontalProductListCard(productList: [
                  controller.memberCenter!.browseInfo!,
                  controller.memberCenter!.bestSellersInfo
                ]),
                BannerCard(
                    imageUrls: List.generate(
                        controller.memberCenter!.banners.length,
                        (index) =>
                            controller.memberCenter!.banners[index].image))
              ],
            ));
      }
      return Container();
    });
  }
}
