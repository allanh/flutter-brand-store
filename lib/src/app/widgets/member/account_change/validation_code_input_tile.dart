import 'package:flutter/material.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';

class ValidationCodeInputTile extends StatefulWidget {
  const ValidationCodeInputTile({
    Key? key,
    required this.handleValidationCodeChange,
    required this.isValid,
  }) : super(key: key);

  final void Function(String) handleValidationCodeChange;
  final bool isValid;

  @override
  State<ValidationCodeInputTile> createState() =>
      _ValidationCodeInputTileState();
}

class _ValidationCodeInputTileState extends State<ValidationCodeInputTile> {
  bool _isShowDescription = true;
  final List<String> _code = [];
  final FocusScopeNode _node = FocusScopeNode();

  void handleCodeChange(text, index) {
    /// 輸入數字，文字不為空值
    if (text.isNotEmpty) {
      /// 將數字插入陣列並指定索引值
      _code.insert(index, text);

      /// 如果輸入完成且不是最後一個數字
      if (index < 3) {
        /// 自動將游標切換到下一個輸入框
        _node.nextFocus();
      } else {
        /// 輸入完最後一個數字，取消游標
        _node.unfocus();
      }
    } else {
      /// 刪除數字時，內容為空值
      /// 將陣列中相同索引值的內容刪除
      _code.removeAt(index);

      /// 如果不是第一個輸入框
      if (index > 0) {
        /// 自動切換到前一個輸入框
        _node.previousFocus();
      }
    }

    /// 將陣列轉成文字後傳出
    widget.handleValidationCodeChange(_code.join());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: FocusScope(
            node: _node,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildFocusTraversalGroupedField(context, 0),
                const SizedBox(width: 16.0),
                _buildFocusTraversalGroupedField(context, 1),
                const SizedBox(width: 16.0),
                _buildFocusTraversalGroupedField(context, 2),
                const SizedBox(width: 16.0),
                _buildFocusTraversalGroupedField(context, 3),
              ],
            )),
      ),
    ];

    if (_isShowDescription) {
      children.add(
        GestureDetector(
            onTap: () {
              setState(() {
                _isShowDescription = false;
                _node.nextFocus();
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Text(
                '請輸入驗證簡訊4位數驗證碼',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: UdiColors.brownGrey),
              ),
            )),
      );
    }

    return Stack(alignment: Alignment.center, children: children);
  }

  FocusTraversalGroup _buildFocusTraversalGroupedField(
    BuildContext context,
    int index,
  ) {
    final double _fieldWidth =
        (MediaQuery.of(context).size.width - 24.0 - 24.0 - 16.0 - 16.0 - 16.0) /
            4;
    final _underlineColor =
        widget.isValid ? UdiColors.veryLightGrey2 : UdiColors.strawberry;
    final UnderlineInputBorder _underlineInputBorder =
        UnderlineInputBorder(borderSide: BorderSide(color: _underlineColor));

    return FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: SizedBox(
          width: _fieldWidth,
          child: FocusTraversalOrder(
              order: NumericFocusOrder(index.toDouble()),
              child: TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                    color: UdiColors.greyishBrown),
                maxLength: 1,
                onChanged: (text) => handleCodeChange(text, index),
                onTap: () {
                  setState(() => _isShowDescription = false);
                },
                cursorColor: UdiColors.brownGrey2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  hintStyle: const TextStyle(color: UdiColors.brownGrey2),
                  border: _underlineInputBorder,
                  enabledBorder: _underlineInputBorder,
                  focusedBorder: _underlineInputBorder,
                ),
              )),
        ));
  }
}
