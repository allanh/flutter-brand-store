import 'package:intl/intl.dart';

const String rootRouteName = 'root';
const String homeRouteName = 'home'; // 首頁
const String staticRouteName = 'static'; // 靜態頁
const String registerRouteName = 'register'; // 註冊頁
const String loginRouteName = 'login'; // 登入頁

const String mainRouteName = 'main'; // 主頁
const String mainProductRouteName = 'main-product'; // 主頁->商品頁
const String productRouteName = 'product'; // 商品頁
const String favoriteRouteName = 'favorite'; // 收藏頁
const String memberRouteName = 'member'; // 會員頁
const String cartRouteName = 'cart'; // 購物車

const String signinInfoRouteName = 'signin';
const String moreInfoRouteName = 'moreInfo';
const String paymentRouteName = 'payment';
const String personalRouteName = 'personal';
const String searchRouteName = 'search'; // 搜尋頁

// DeepLink
const String profileMoreInfoRouteName = 'profile-moreInfo';
const String profilePaymentRouteName = 'profile-payment';
const String profilePersonalRouteName = 'profile-personal';
const String profileSigninInfoRouteName = 'profile-signin';

const String inputFormat = 'yyyy-MM-dd HH:mm:ss';
const String outputFormat = 'yyyy/MM/dd HH:mm:ss';

// 價格格式
NumberFormat numberFormat = NumberFormat("#,###");

class QueryKey {
  static const String goodsNo = 'goods_no';
  static const String productId = 'product_id';
}
