import 'package:intl/intl.dart';

const String rootRouteName = 'root';
const String homeRouteName = 'home'; // 首頁
const String staticRouteName = 'static'; // 靜態頁
const String registerRouteName = 'register'; // 註冊頁
const String loginRouteName = 'login'; // 登入頁
const String forgetPasswordRouteName = 'forget-password'; // 忘記密碼頁
const String verifyMobileCodeRouteName = 'verify-mobile-code'; // 驗證簡訊驗證碼
const String resetPasswordRouteName = 'reset-password'; // 驗證簡訊驗證碼

const String mainRouteName = 'main'; // 主頁
const String mainProductRouteName = 'main-product'; // 主頁->商品頁
const String mainProductImageRouteName = 'main-product-image'; // 主頁->商品頁->圖片
const String productRouteName = 'product'; // 商品頁
const String specName = 'spec'; // 規格頁

const String favoriteRouteName = 'favorite'; // 收藏頁
const String memberRouteName = 'member'; // 會員頁
const String cartRouteName = 'cart'; // 購物車

const String serviceRouteName = 'service'; // 幫助中心
const String faqRouteName = 'faq'; // 常見問題
const String bulletinRouteName = 'bulletin'; // 服務公告
const String termsRouteName = 'terms'; // 會員服務條款
const String privacyRouteName = 'privacy'; // 隱私權條款
const String aboutRouteName = 'about'; // 關於我們

const String signinInfoRouteName = 'signin';
const String moreInfoRouteName = 'moreInfo';
const String paymentRouteName = 'payment';
const String personalRouteName = 'personal';
const String searchRouteName = 'search'; // 搜尋頁

/// 會員中心
const String boughtProductsRouteName = 'bought-products'; // 買過商品
const String browseProductsRouteName = 'browse-products'; // 瀏覽紀錄
const String memberProfileRouteName = 'member-profile'; // 會員資料
const String memberLevelInfoRouteName = 'member-level-info'; // 會員等級說明
const String mobileAccountChangeRouteName = 'mobile-acount-change'; // 會員手機帳號變更
const String emailAccountChangeRouteName = 'email-account-change'; // 會員信箱帳號變更
const String checkoutSettingRouteName = 'checkout-setting'; // 結帳設定
const String invoiceSettingRouteName = 'invoice-setting'; // 發票設定
const String donationCodeWebRouteName = 'donation-code-web'; // 捐贈碼查詢
const String carrierRegisterWebRouteName = 'carrier-register-web'; // 載具歸戶網頁
const String shippingInfosRouteName = 'shipping-infos'; // 常用收件地址
const String shippingInfoDetailRouteName = 'shipping-info-detail'; // 新增常用收件地址

// DeepLink
const String productImageRouteName = 'product-imaege'; // 商品頁->圖片
const String productSpecRouteName = 'product-spec'; // 商品頁->規格
const String profileMoreInfoRouteName = 'profile-moreInfo';
const String profilePaymentRouteName = 'profile-payment';
const String profilePersonalRouteName = 'profile-personal';
const String profileSigninInfoRouteName = 'profile-signin';

const String originalFullDateFormat = 'yyyy-MM-dd HH:mm:ss';
const String fullDateFormat = 'yyyy/MM/dd HH:mm:ss';
const String shortDateFormat = 'yyyy/MM/dd';
const String serverDateFormat = 'yyyy-MM-dd';

// 價格格式
NumberFormat numberFormat = NumberFormat("#,###");

class QueryKey {
  static const String tab = 'tab';
  static const String goodsNo = 'goods_no';
  static const String productId = 'product_id';
  static const String index = 'index';
  static const String imagePaths = 'imagePaths';
  static const String product = 'product';
  static const String productController = 'productController';
}
