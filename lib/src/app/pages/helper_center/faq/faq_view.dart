import 'package:brandstores/src/data/repositories/data_helper_center_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_html/flutter_html.dart';

import 'faq_controller.dart';

class FaqPage extends View {
  FaqPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends ViewState<FaqPage, FaqController> {
  _PageState() : super(FaqController(DataHelperCenterRepository()));

  @override
  Widget get view {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: SingleChildScrollView(
        child: ControlledWidgetBuilder<FaqController>(
          builder: (context, controller) {
            return Html(
                data: controller.faq?.groups.first.items.first.body ?? '');
          },
        ),
      ),
    );
  }
}
