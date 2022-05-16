import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';

import '../../../data/repositories/data_modules_repository.dart';
import '../../../domain/entities/module/module.dart';
<<<<<<< HEAD
import '../../widgets/home/ad_wiget.dart';
import '../../widgets/home/product_widget.dart';
import '../../widgets/home/video_widget.dart';
=======
import '../../../domain/entities/module/image_list_item.dart';
import '../../../domain/entities/link.dart';
import '../helper_center/helper_center_view.dart';
import './home_controller.dart';
import '../../utils/constants.dart';
>>>>>>> dev

class HomePage extends View {
  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomePageState createState() =>
      // inject dependencies inwards
      _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState() : super(HomeController(DataModulesRepository()));

<<<<<<< HEAD
  Widget _buildWidget(BuildContext context, Module module) {
    switch (module.type) {
      case ModuleType.product:
        return (module.products != null && (module.products?.length ?? 0) > 0)
            ? ProductWidget(module: module)
            : Container();
      case ModuleType.ad:
        return (module.images != null && (module.images?.length ?? 0) > 0)
            ? AdWidget(module: module)
            : Container();
      case ModuleType.video:
        return VideoWidget(
          module: module,
        );
=======
  void _onItemTapped(Link? link) {
    if (link != null) {
      switch (link.type) {
        case LinkType.product:
          context.goNamed(productRouteName,
              params: {QueryKey.goodsNo: link.value});
          break;
        default:
          debugPrint('default link');
      }
    } else {
      debugPrint('no link');
    }
  }

  Widget _indicator(bool isActive) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: const Color(0XFF2FB7B2).withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : const BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? const Color(0XFF6BC4C9) : const Color(0XFFEAEAEA),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator(Module module) {
    List<Widget> list = [];
    for (int i = 0; i < module.images!.length; i++) {
      list.add(
          i == module.selectedIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _buildProductItem(BuildContext context, ModuleItem moduleItem) {
    return GestureDetector(
        onTap: () => _onItemTapped(moduleItem.link),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: (moduleItem.image != null)
                  ? Image.network(moduleItem.image!)
                  : Container(),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15.0, top: 8.0),
              child: Text(moduleItem.name),
            ),
          ],
        ));
  }

  Widget _buildImageItem(BuildContext context, ImageListItem imageListItem,
      bool showContent, double height) {
    final width = MediaQuery.of(context).size.width;
    if (showContent) {
      return SizedBox(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(imageListItem.image),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(top: 8),
                        child: Text(imageListItem.title ?? ''),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      height: 48,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(top: 8),
                        child: Text(imageListItem.content ?? ''),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      height: 32,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(top: 8),
                        child: Text(imageListItem.start.toString() +
                            '-' +
                            imageListItem.end.toString()),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ));
    } else {
      return Image.network(imageListItem.image);
    }
  }

  Widget _buildModuleTitle(BuildContext context, Module module) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 43,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 14.0, 12.0, 7.0),
          child: Text(module.title),
        ));
  }

  Widget _buildWidget(BuildContext context, Module module) {
    if (module.type == ModuleType.product) {
      if (module.products != null && (module.products?.length ?? 0) > 0) {
        final int length = module.products!.length;
        final items = module.products!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (module.showTitle)
                ? Text(module.title)
                : Container(
                    decoration: const BoxDecoration(color: Colors.red),
                  ),
            GridView.builder(
                itemCount: length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.0 / 4.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  // return const Text('grid view item builder');
                  return _buildProductItem(context, items[index]);
                }),
          ],
        );
      }
      return Container();
    } else if (module.type == ModuleType.ad) {
      if (module.images != null && (module.images?.length ?? 0) > 0) {
        final images = module.images!;
        final ratio = module.size!.ratio;
        final width = MediaQuery.of(context).size.width;
        final contentNotEmpty = module.contentNotEmpty;
        final height = width * ratio + (contentNotEmpty ? 110.0 : 0.0);
        if (contentNotEmpty) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(
                top: 10), // top padding for title
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (module.showTitle)
                    ? _buildModuleTitle(context, module)
                    : Container(
                        decoration: const BoxDecoration(color: Colors.red),
                      ),
                SizedBox(
                  width: width,
                  height: height,
                  child: PageView.builder(
                    controller: module.controller,
                    onPageChanged: (int page) {
                      setState(() {
                        module.selectedIndex = page;
                      });
                    },
                    itemCount: module.images!.length,
                    itemBuilder: (context, index) => _buildImageItem(context,
                        module.images![index], contentNotEmpty, height),
                  ),
                ),
                SizedBox(
                  width: width,
                  height: 15,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(module),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsetsDirectional.only(top: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              (module.showTitle)
                  ? _buildModuleTitle(context, module)
                  : Container(
                      decoration: const BoxDecoration(color: Colors.red),
                    ),
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  SizedBox(
                    width: width,
                    height: height,
                    child: PageView.builder(
                      controller: module.controller,
                      onPageChanged: (int page) {
                        setState(() {
                          module.selectedIndex = page;
                        });
                      },
                      itemCount: module.images!.length,
                      itemBuilder: (context, index) => _buildImageItem(context,
                          module.images![index], contentNotEmpty, height),
                    ),
                  ),
                  // SizedBox(
                  //   width: width,
                  //   height: 15,
                  //   child: Padding(
                  // padding: const EdgeInsets.only(top: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(module),
                  ),
                  // ),
                  // ),
                ],
              )
            ]),
          );
        }
      }
      return Container();
>>>>>>> dev
    }
  }

  @override
  Widget get view {
    return ControlledWidgetBuilder<HomeController>(
      builder: (context, controller) {
        if (controller.moduleList != null) {
          final moduleList = controller.moduleList!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: moduleList.goodModules.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildWidget(context, moduleList.goodModules[index]);
                  },
                ),
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
