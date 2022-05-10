import 'package:flutter/material.dart';
import 'package:brandstores/src/domain/entities/member_center/member_center.dart';

class HorizontalProductListCard extends StatefulWidget {
  const HorizontalProductListCard({Key? key, required this.productList})
      : super(key: key);

  final List<ProductInfo> productList;

  @override
  State<HorizontalProductListCard> createState() =>
      _HorizontalProductListCardState();
}

class _HorizontalProductListCardState extends State<HorizontalProductListCard> {
  @override
  Widget build(BuildContext context) {
    const space = 8.0;
    const marginWitdh = 12.0;

    return SizedBox(
        height: 312.0,
        child: Card(
          child: Column(
            children: [
              /// 頁籤
              const TabButtonBar(),

              /// 商品清單
              HorizontalProductListView(widget: widget, space: space),
            ],
          ),
          color: Colors.white,
          elevation: 5,
          margin:
              const EdgeInsets.fromLTRB(marginWitdh, 0.0, marginWitdh, 16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ));
  }
}

class TabButtonBar extends StatefulWidget {
  const TabButtonBar({
    Key? key,
  }) : super(key: key);

  @override
  State<TabButtonBar> createState() => _TabButtonBarState();
}

class _TabButtonBarState extends State<TabButtonBar> {
  /// 儲存按鈕名稱，用來產生按鈕
  final List<String> _buttons = ["最新商品", '熱銷商品'];

  /// 按鈕點擊狀態
  List<bool> _actives = [true, false];

  void _handleChange(TabButton button) {
    setState(() {
      /// 改變按鈕點擊狀態
      _actives = [button.title == _buttons[0], button.title == _buttons[1]];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
        buttonHeight: 40.0,
        buttonPadding: EdgeInsets.zero,
        children: List.generate(
            _buttons.length,
            (index) => TabButton(
                  title: _buttons[index],
                  active: _actives[index],
                  onChanged: _handleChange,
                )));
  }
}

class TabButton extends StatelessWidget {
  const TabButton(
      {Key? key,
      required this.title,
      this.active = false,
      required this.onChanged})
      : super(key: key);

  final String title;
  final bool active;
  final ValueChanged<TabButton> onChanged;

  void _handleTap() {
    onChanged(this);
  }

  @override
  Widget build(BuildContext context) {
    const marginWitdh = 12.0;
    const indicatorHeight = 3.0;
    final tabWidth =
        (MediaQuery.of(context).size.width - (marginWitdh * 2)) * 0.5;
    return Container(
        alignment: Alignment.center,
        width: tabWidth,
        decoration: BoxDecoration(
            color: active ? Colors.white : Colors.black12,
            border: Border(
                top: BorderSide(
                    color: active ? Colors.orange : Colors.black12,
                    width: active ? indicatorHeight : 0))),
        child: TextButton(
            style: TextButton.styleFrom(
                primary: active ? Colors.orange : Colors.black45,
                fixedSize: Size(tabWidth, double.infinity),
                splashFactory: NoSplash.splashFactory),
            child: Text(title),
            onPressed: _handleTap));
  }
}

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    Key? key,
    required this.widget,
    required this.space,
  }) : super(key: key);

  final HorizontalProductListCard widget;
  final double space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 242,
      child:

          /// 如果沒有任何商品，就顯示無商品畫面
          widget.productList[0].list!.isEmpty

              /// 無商品畫面
              ? const EmptyProductView()

              /// 商品清單
              : ListView(
                  scrollDirection: Axis.horizontal,
                  children:

                      /// 產生 15 個商品
                      List.generate(
                    15,
                    (index) =>
                        ProductView(space: space, widget: widget, index: index),
                  )),
    );
  }
}

class ProductView extends StatelessWidget {
  const ProductView(
      {Key? key,
      required this.space,
      required this.widget,
      required this.index})
      : super(key: key);

  final double space;
  final HorizontalProductListCard widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: space, right: space),
        child:

            /// 商品 UI
            SizedBox(
          width: 130,
          child: Column(children: [
            /// 商品圖片
            ProductImage(imageUrl: widget.productList[0].list?[index].imageUrl),
            const SizedBox(height: 8),

            /// 商品名稱
            ProductName(
              name: widget.productList[0].list?[index].name ?? '',
            ),
            const SizedBox(height: 8),

            /// 商品價格區塊
            Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Row(
                  children: [
                    /// 價格
                    Expanded(
                      flex: 2,
                      child: PriceView(
                          price: widget.productList[0].list?[index].maxPrice
                                  .toString() ??
                              ''),
                    ),

                    /// 收藏按鈕
                    const Expanded(flex: 1, child: FavoriteButton())
                  ],
                ))
          ]),
        ));
  }
}

class EmptyProductView extends StatelessWidget {
  const EmptyProductView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Image(
          image: AssetImage('assets/empty_cart.png'),
        ),
        SizedBox(height: 24.0),
        Text('目前尚未有最新商品。',
            style: TextStyle(
                fontFamily: 'PingFangTC-Regular',
                fontSize: 14.0,
                color: Color.fromRGBO(127, 127, 127, 1)))
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 130,
        height: 130,
        child: Image(
          fit: BoxFit.contain,
          image: NetworkImage(imageUrl ?? 'https://via.placeholder.com/150'),
        ));
  }
}

class ProductName extends StatelessWidget {
  const ProductName({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Text(name,
          style: const TextStyle(
              fontFamily: 'PingFangTC-Regular',
              fontSize: 14.0,
              color: Color.fromRGBO(76, 76, 76, 1))),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  void _handleTap() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: _handleTap,
        child: Image(
          color: _isFavorite ? Colors.red : Colors.black54,
          fit: BoxFit.scaleDown,
          image: _isFavorite
              ? const AssetImage('assets/icon_fill_heart.png')
              : const AssetImage('assets/icon_heart.png'),
        ));
  }
}

class PriceView extends StatelessWidget {
  const PriceView({
    Key? key,
    required this.price,
  }) : super(key: key);

  final String price;

  @override
  Widget build(BuildContext context) {
    return Text("\$ $price",
        style: const TextStyle(
            fontFamily: 'PingFangTC-Semibold',
            fontSize: 16.0,
            color: Color.fromRGBO(242, 63, 68, 1)));
  }
}
