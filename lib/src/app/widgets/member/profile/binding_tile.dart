import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/member/member_profile.dart';

/// 建立綁定畫面
class BindingTile extends StatelessWidget {
  const BindingTile({
    Key? key,
    required this.context,
    required this.binding,
    required this.image,
    required this.isBinding,
    required this.handleBinding,
  }) : super(key: key);

  final BuildContext context;
  final Binding? binding;
  final String image;
  final bool isBinding;
  final void Function(Binding? p1) handleBinding;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: SizedBox(
            width: double.infinity,
            height: 66.0,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image(height: 46.0, width: 46.0, image: AssetImage(image)),
                    const SizedBox(width: 16.0),
                    Text(isBinding ? '已綁定' : '尚未綁定',
                        style: const TextStyle(
                            color: UdiColors.brownGrey,
                            fontFamily: 'PingFangTC Regular',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0))
                  ]),
                  Row(children: [
                    isBinding
                        ? OutlinedButton(
                            onPressed: () => handleBinding(binding),
                            child: Text('解除綁定',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor)))
                        : ElevatedButton(
                            onPressed: () => handleBinding(binding),
                            child: const Text('立即綁定'),
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor))
                  ])
                ])));
  }
}
