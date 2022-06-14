import 'package:flutter/material.dart';

class CarrierActionButtons extends StatefulWidget {
  const CarrierActionButtons({Key? key}) : super(key: key);

  @override
  State<CarrierActionButtons> createState() => _CarrierActionButtonsState();
}

class _CarrierActionButtonsState extends State<CarrierActionButtons> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.0,
      width: 173.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
              onPressed: () {},
              child: Text('清除資料',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context).appBarTheme.backgroundColor))),
          const ElevatedButton(onPressed: null, child: Text('儲存'))
        ],
      ),
    );
  }
}
