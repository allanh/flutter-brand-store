import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/product/event.dart';

/// 促銷活動列
class ProductEventsView extends StatelessWidget {
  const ProductEventsView({Key? key, required this.eventList})
      : super(key: key);

  final List<Event> eventList;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (var event in eventList) {
      if (event.discountWording != null) {
        list.add(ProductEventView(event: event));
      }
    }
    // 最多顯示兩筆
    return FittedBox(
        child: Row(
      children: list.take(2).toList(),
    ));
  }
}

/// 單一促銷活動
class ProductEventView extends StatelessWidget {
  const ProductEventView({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
          color: event.eventOnline == true
              ? UdiColors.pumpkinOrange.withOpacity(0.1)
              : UdiColors.white2),
      child: Row(children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: event.eventOnline == true
                        ? UdiColors.pumpkinOrange
                        : UdiColors.pinkishGrey),
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.white),
            child:
                // 活動類型
                Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: Text(event.ruleType!.productLabelName,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: event.eventOnline == true
                                  ? UdiColors.pumpkinOrange
                                  : UdiColors.brownGreyTwo,
                              height: 1.4166,
                              fontSize: 12.0,
                            )))),
        // 活動內容
        Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: Text(event.discountWording!,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: event.eventOnline == true
                          ? UdiColors.pumpkinOrange
                          : UdiColors.brownGreyTwo,
                      height: 1.4166,
                      fontSize: 12.0,
                    )))
      ]));
}
