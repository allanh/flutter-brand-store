import 'package:brandstores/src/app/utils/constants.dart';
import 'package:brandstores/src/device/utils/my_plus_colors.dart';
import 'package:brandstores/src/domain/entities/member_center/member_products/member_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:brandstores/src/app/pages/member_center/products/member_products_controller.dart';
import 'package:brandstores/src/data/repositories/data_member_products_repository.dart';
import 'package:go_router/go_router.dart';

enum MemberProductsType { history, favorite, bought }

extension MemberProductsExtension on MemberProductsType {
  String get value {
    switch (this) {
      case MemberProductsType.history:
        return '瀏覽紀錄';
      case MemberProductsType.favorite:
        return '我的收藏';
      case MemberProductsType.bought:
        return '買過商品';
    }
  }
}

class MemberProductsPage extends View {
  MemberProductsPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  final MemberProductsType type;

  @override
  _MemberProductsPageState createState() => _MemberProductsPageState();
}

class _MemberProductsPageState
    extends ViewState<MemberProductsPage, MemberProductsController> {
  _MemberProductsPageState()
      : super(MemberProductsController(DataMemberProductsRepository()));

  void handleGoHome(BuildContext context) {
    context.goNamed(rootRouteName);
  }

  @override
  Widget get view {
    return ControlledWidgetBuilder<MemberProductsController>(
        builder: (context, controller) {
      MemberProducts? bought = controller.boughtProducts;
      MemberProducts? favorite = controller.favoriteProducts;
      MemberProducts? history = controller.historyProducts;
      return Scaffold(
        key: globalKey,
        appBar: AppBar(title: const Text('我的商品'), actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () => debugPrint('open shopping cart'),
                icon: const Icon(Icons.shopping_cart_outlined)),
          )
        ]),
        body: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                initialIndex: widget.type.index,
                length: MemberProductsType.values.length,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildTabBar(context),
                      _buildTabBarView(context, bought, favorite, history),
                    ]),
              ),
            ),
          ],
        ),
      );
    });
  }

  Container _buildTabBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: TabBar(
        labelPadding: EdgeInsets.zero,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).appBarTheme.backgroundColor!,
              width: 2,
            ),
          ),
        ),
        labelColor: Theme.of(context).appBarTheme.backgroundColor,
        unselectedLabelColor: UdiColors.brownGrey,
        tabs: _buildTabs(context),
      ),
    );
  }

  List<Widget> _buildTabs(BuildContext context) {
    return List.generate(
      MemberProductsType.values.length,
      (index) => SizedBox(
        width: MediaQuery.of(context).size.width /
            MemberProductsType.values.length,
        height: 40.0,
        child: Tab(text: MemberProductsType.values[index].value),
      ),
    );
  }

  Expanded _buildTabBarView(BuildContext context, MemberProducts? bought,
      MemberProducts? favorite, MemberProducts? history) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TabBarView(
              children: [
                history != null && history.products.isNotEmpty
                    ? _buildHistoryProductView(history.products, context)
                    : _buildEmptyView(MemberProductsType.history, handleGoHome),
                favorite != null && favorite.products.isNotEmpty
                    ? _buildFavoriteProductView(favorite.products, context)
                    : _buildEmptyView(
                        MemberProductsType.favorite, handleGoHome),
                bought != null && bought.products.isNotEmpty
                    ? _buildBoughtProductView(bought.products, context)
                    : _buildEmptyView(MemberProductsType.bought, handleGoHome),
              ],
            )));
  }

  Column _buildFavoriteProductView(
    List<MemberProduct> products,
    BuildContext context,
  ) {
    String? selectedValue = 'ALL';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 12.0),
          child: SizedBox(
            height: 36.0,
            width: 108.0,
            child: InputDecorator(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: UdiColors.veryLightGrey2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: UdiColors.greyishBrown,
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_outlined,
                      size: 24.0),
                  isDense: true,
                  isExpanded: true,
                  value: selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  items: const [
                    DropdownMenuItem(child: Text('全部收藏'), value: 'ALL')
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: _buildProductView(
                products, context, MemberProductsType.favorite)),
      ],
    );
  }

  Column _buildBoughtProductView(
    List<MemberProduct> products,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 12.0),
          child: SizedBox(
            height: 30.0,
            child: Text('您最近一年內購買的商品。',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: UdiColors.brownGrey)),
          ),
        ),
        Expanded(
            child: _buildProductView(
                products, context, MemberProductsType.bought)),
      ],
    );
  }

  Column _buildHistoryProductView(
    List<MemberProduct> products,
    BuildContext context,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: SizedBox(
            height: 30.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('您最近三個月內瀏覽的商品。',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: UdiColors.brownGrey)),
                  SizedBox(
                    height: 24.0,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('刪除全部'),
                      style: OutlinedButton.styleFrom(
                        primary: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                    ),
                  )
                ]),
          ),
        ),
        Expanded(
            child: _buildProductView(
                products, context, MemberProductsType.history)),
      ],
    );
  }

  ListView _buildProductView(
    List<MemberProduct> products,
    BuildContext context,
    MemberProductsType type,
  ) {
    return ListView(children: _buildProductLists(products, context, type));
  }

  List<Widget> _buildProductLists(
    List<MemberProduct> products,
    BuildContext context,
    MemberProductsType type,
  ) {
    return List.generate(products.length,
        (index) => _buildProductList(context, products[index], type));
  }

  Image _buildEmptyImage(MemberProductsType type) {
    return Image(
      image: AssetImage(type == MemberProductsType.history
          ? 'assets/images/empty_browser.png'
          : type == MemberProductsType.favorite
              ? 'assets/images/empty_favorite.png'
              : 'assets/images/empty_bought.png'),
      width: 120.0,
      height: 120.0,
    );
  }

  Text _buildEmptyMessage(
    BuildContext context,
    MemberProductsType type,
  ) {
    return Text(
        type == MemberProductsType.history
            ? '您目前沒有瀏覽紀錄'
            : type == MemberProductsType.favorite
                ? '您目前沒有收藏商品'
                : '您目前沒有買過東西',
        style: Theme.of(context)
            .textTheme
            .caption
            ?.copyWith(color: UdiColors.brownGrey));
  }

  Center _buildEmptyView(
    MemberProductsType type,
    Function(BuildContext context) handleGoHome,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEmptyImage(type),
          const SizedBox(height: 20.0),
          _buildEmptyMessage(context, type),
          const SizedBox(height: 24.0),
          SizedBox(
            width: 108.0,
            height: 36.0,
            child: ElevatedButton(
                onPressed: () => handleGoHome(context),
                child: const Text('來去逛逛'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                )),
          )
        ],
      ),
    );
  }

  SizedBox _buildProductList(
    BuildContext context,
    MemberProduct product,
    MemberProductsType type,
  ) {
    return SizedBox(
      height: 146.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildProductImage(product),
            const SizedBox(width: 8.0),
            _buildProductInformation(context, product, type),
          ],
        ),
      ),
    );
  }

  Expanded _buildProductInformation(
    BuildContext context,
    MemberProduct product,
    MemberProductsType type,
  ) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductName(product, context),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPrice(product, context),
                  _buildActionButtons(type),
                ],
              )
            ],
          ),
          _buildDateInfomation(product)
        ],
      ),
    );
  }

  Padding _buildDateInfomation(MemberProduct product) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.access_time_filled,
              size: 14.0, color: UdiColors.brownGrey2),
          const SizedBox(width: 4.0),
          Text(product.saleDate ?? '',
              style:
                  const TextStyle(fontSize: 12.0, color: UdiColors.brownGrey))
        ],
      ),
    );
  }

  SizedBox _buildProductImage(MemberProduct product) {
    return SizedBox(
      width: 130.0,
      height: 130.0,
      child: Image(
        image: NetworkImage(product.imageUrl ?? ''),
      ),
    );
  }

  Padding _buildProductName(MemberProduct product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 12.0),
      child: Text(product.name ?? '',
          softWrap: true,
          maxLines: 2,
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: UdiColors.greyishBrown,
              )),
    );
  }

  Row _buildActionButtons(MemberProductsType type) {
    List<IconButton> buttons = [
      IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          color: UdiColors.brownGrey,
          iconSize: 28.0,
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_outlined)),
      IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          color: UdiColors.brownGrey,
          iconSize: 28.0,
          onPressed: () {},
          icon: type == MemberProductsType.favorite
              ? Icon(
                  Icons.favorite,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                )
              : const Icon(Icons.favorite_outline)),
    ];
    if (type == MemberProductsType.history) {
      buttons.insert(
        1,
        IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          color: UdiColors.brownGrey,
          iconSize: 28.0,
          onPressed: () {},
          icon: const Icon(Icons.delete_outline_outlined),
        ),
      );
    }
    return Row(children: buttons);
  }

  Row _buildPrice(MemberProduct product, BuildContext context) {
    return Row(
      children: [
        Text('\$ ${product.minPrice.toString()}',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: UdiColors.strawberry,
                )),
      ],
    );
  }
}
