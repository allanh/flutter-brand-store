import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repositories/data_modules_repository.dart';
import '../../../domain/entities/module/module.dart';
import '../../widgets/home/ad_wiget.dart';
import '../../widgets/home/product_widget.dart';
import '../../widgets/home/video_widget.dart';
import './home_controller.dart';

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
    }
  }
  @override
  Widget get view {
    return ControlledWidgetBuilder<HomeController>(
      builder: (context, controller) {
        if (controller.moduleList != null) {
          final moduleList = controller.moduleList!;
          return Scaffold(
            key: globalKey,
            body: Column(
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
            )
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
