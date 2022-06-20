import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../data/repositories/member_center/data_invoice_setting_repository.dart';
import 'invoice_setting_controller.dart';

class InvoiceSettingPage extends View {
  InvoiceSettingPage({
    Key? key,
  }) : super(key: key);

  @override
  _InvoiceSettingPageState createState() => _InvoiceSettingPageState();
}

class _InvoiceSettingPageState
    extends ViewState<InvoiceSettingPage, InvoiceSettingController> {
  _InvoiceSettingPageState()
      : super(
          InvoiceSettingController(
            DataInvoiceSettingRepository(),
          ),
        );
  final List<int> _items = List<int>.generate(5, (int index) => index);
  @override
  Widget get view {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return ControlledWidgetBuilder<InvoiceSettingController>(
        builder: (context, controller) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('發票設定'),
          ),
          body: ReorderableListView(
            header: Column(
              children: [
                const SizedBox(height: 12.0),
                Text('結帳時，發票預設為會員載具，您可以設定其他常用的發票資料。',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: UdiColors.brownGrey)),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Container(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        height: 24.0,
                        width: 4.0),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text('預設發票設定',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: UdiColors.greyishBrown))
                  ],
                ),
                const SizedBox(height: 12.0),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: <Widget>[
              for (int index = 0; index < _items.length; index += 1)
                ListTile(
                  key: Key('$index'),
                  tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                  title: Text('Item ${_items[index]}'),
                  trailing: const Icon(Icons.drag_handle),
                ),
            ],
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final int item = _items.removeAt(oldIndex);
                _items.insert(newIndex, item);
              });
            },
          ));
    });
  }
}
