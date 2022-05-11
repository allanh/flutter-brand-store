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
  /// 儲存按鈕名稱，用來產生按鈕
  final List<String> _tabs = ["最新商品", '熱銷商品'];

  /// 按鈕點擊狀態
  List<bool> _actives = [];

  /// 當前顯示的商品清單
  List<Product> _currentProducts = [];

  @override
  void initState() {
    super.initState();

    /// 指定商品清單預設顯示內容
    _currentProducts = widget.productList[0].list ?? [];

    /// 指定第一個頁籤為點擊狀態
    _actives = List.generate(_tabs.length, (index) => index == 0);
  }

  void _handleTap(TabButton tabButton) {
    final index = _tabs.indexOf(tabButton.title);
    setState(() {
      _currentProducts = widget.productList[index].list ?? [];
      _actives = List.generate(
          _tabs.length, (index) => _tabs[index] == tabButton.title);
    });
  }

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
              TabButtonBar(
                onChanged: _handleTap,
                tabs: _tabs,
                actives: _actives,
              ),

              /// 商品清單
              HorizontalProductListView(
                // widget: widget,
                space: space,
                products: _currentProducts,
              ),
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

class TabButtonBar extends StatelessWidget {
  const TabButtonBar(
      {Key? key,
      required this.tabs,
      required this.actives,
      required this.onChanged})
      : super(key: key);

  final List<String> tabs;
  final List<bool> actives;
  final ValueChanged<TabButton> onChanged;

  void _handleChange(TabButton tabButton) {
    onChanged(tabButton);
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
        buttonHeight: 40.0,
        buttonPadding: EdgeInsets.zero,
        children: List.generate(
            tabs.length,
            (index) => TabButton(
                  title: tabs[index],
                  active: actives[index],
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
    final ThemeData theme = Theme.of(context);

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
                    color: active
                        ? theme.appBarTheme.backgroundColor!
                        : Colors.black12,
                    width: active ? indicatorHeight : 0))),
        child: TextButton(
            style: TextButton.styleFrom(
                primary: active
                    ? theme.appBarTheme.backgroundColor!
                    : Colors.black45,
                fixedSize: Size(tabWidth, double.infinity),
                splashFactory: NoSplash.splashFactory),
            child: Text(title),
            onPressed: _handleTap));
  }
}

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    Key? key,
    required this.space,
    required this.products,
  }) : super(key: key);

  final double space;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 242,
      child:

          /// 如果沒有任何商品，就顯示無商品畫面
          products.isEmpty

              /// 無商品畫面
              ? const EmptyProductView()

              /// 商品清單
              : ListView(
                  scrollDirection: Axis.horizontal,
                  children:

                      /// 產生 15 個商品
                      _buildProductList()),
    );
  }

  List<Widget> _buildProductList() {
    return List.generate(
      products.length,
      (index) =>
          ProductView(space: space, product: products[index], index: index),
    );
  }
}

class ProductView extends StatelessWidget {
  const ProductView(
      {Key? key,
      required this.space,
      required this.product,
      required this.index})
      : super(key: key);

  final double space;
  final int index;
  final Product product;
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
            ProductImage(imageUrl: product.imageUrl),
            const SizedBox(height: 8),

            /// 商品名稱
            ProductName(
              name: product.name,
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
                      child: PriceView(price: product.maxPrice.toString()),
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
