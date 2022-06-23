import 'package:brandstores/src/app/widgets/product/selected_border_widget.dart';
import 'package:flutter/material.dart';

import '../../../../device/utils/my_plus_colors.dart';
import '../../../../domain/entities/product/spec_sku.dart';
import '../../common/aspect_ratio_image_widget.dart';

/// 單一規格
class SpecItemWidget extends StatelessWidget {
  // 顯示類型
  final SpecDisplay displayType;
  final String? text;
  final String? imageUrl;
  // 是否啟用
  final bool isEnabled;
  final bool isSelected;
  final VoidCallback? onItemSelected;

  const SpecItemWidget(
      {Key? key,
      required this.displayType,
      this.text,
      this.imageUrl,
      this.isEnabled = false,
      this.isSelected = false,
      this.onItemSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _primaryColor = Theme.of(context).primaryColor;

    return InkWell(
        // 點擊事件
        onTap: () => {
              if (isEnabled && !isSelected && onItemSelected != null)
                {onItemSelected!()}
            },
        child: Stack(children: [
          Container(
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color:
                        isSelected ? _primaryColor : UdiColors.veryLightGrey2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // 圖片
                  if (imageUrl != null)
                    SizedBox(
                      width: 28,
                      child: AspectRatioImage(
                        url: imageUrl,
                        isEnabled: isEnabled,
                      ),
                    ),

                  // 文字與圖片間格
                  if (text != null && imageUrl != null)
                    const SizedBox(height: 8),

                  // 文字
                  if (text != null)
                    Text(text!,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            height: 1.442857, // 20pt
                            fontSize: 14.0,
                            color: isEnabled
                                ? isSelected
                                    ? _primaryColor
                                    : UdiColors.greyishBrown
                                : UdiColors.brownGrey2))
                ],
              )),

          // 選取時的框線
          if (isSelected)
            Positioned.fill(
                child: SelectedBorderWidget(
              radius: 4.0,
              isSelected: isSelected,
            )),

          // 無法點擊時需蓋個灰色遮罩
          if (isEnabled != true)
            Positioned.fill(
                // Expands to the size of your image
                child: Container(
              decoration: BoxDecoration(
                  color: UdiColors.veryLightGrey2.withOpacity(0.5)),
            ) // Put your Text widgets here in a Stack/Any other way you deem fit
                )
        ]));
  }
}
