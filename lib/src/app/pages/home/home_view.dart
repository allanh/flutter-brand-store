import './home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../data/repositories/data_modules_repository.dart';
import '../../../domain/entities/module/module.dart';
import '../../widgets/home/ad_wiget.dart';
import '../../widgets/home/module_title_widget.dart';

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

  Widget _buildProductItem(BuildContext context, ModuleItem moduleItem) {
    return Column(
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
    );
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
                ? ModuleTitleWidget(module: module)
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
        return AdWidget(module: module);
      }
      return Container();
    }
    return Container();
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
              )
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
