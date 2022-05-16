/// The 'Domain' module defines the business logic of the application. It is a module
/// that is independent from the development platform i.e. it is written purely in the
/// programming language and does not contain any elements from the platform. In the
/// case of 'Flutter', 'Domain' would be written purely in 'Dart' without any 'Flutter'
/// elements. The reason for that is that 'Domain' should only be concerned with
/// the business logic of the application, not with the implementation details.
/// This also allows for easy migration between platform, should any issues arise.

/// 'Entities'
/// - Enterprise-wide business rules
/// - Made up of classes that can contain methods
/// - Business objects of the application
/// - Used application-wide
/// - Least likely to change when something in the application changes

import 'package:json_annotation/json_annotation.dart';
import 'package:brandstores/src/domain/entities/link.dart';
import 'package:intl/intl.dart';

part 'member_center.g.dart';

@JsonSerializable()
class MemberCenterResponse {
  final String id;
  final String status;
  final String? message;

  @JsonKey(name: 'data')
  final MemberCenter memberCenter;

  const MemberCenterResponse(
      this.id, this.status, this.message, this.memberCenter);

  factory MemberCenterResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberCenterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MemberCenterResponseToJson(this);
}

@JsonSerializable()
class MemberCenter {
  final String greeting; // 歡迎訊息
  final Member? member; // 會員相關資料 (PS: 未登入時為 null)
  final Order? order; // 最近訂單 (PS: 未登入時為 null)

  @JsonKey(name: 'order_qa')
  final OrderQA? orderQA; // 問題記錄

  @JsonKey(name: 'notice')
  final NoticeInfo? noticeInfo; // 我的通知 (PS: 未登入時為 null)

  @JsonKey(name: 'service')
  final List<Service> services; // 我的服務

  @JsonKey(name: 'banner')
  final List<Banner> banners; // 廣告清單

  @JsonKey(name: 'favorite')
  final FavoriteInfo? favoriteInfo; // 我的收藏 - WEB/小網/APP (PS: 未登入時為 null)

  @JsonKey(name: 'browse')
  final ProductInfo? browseInfo; // 瀏覽記錄 - WEB/小網/APP (PS: 未登入時為 null)

  @JsonKey(name: 'bought')
  final ProductInfo? boughtInfo; // 買過商品 - WEB/小網/APP (PS: 未登入時為 null)

  @JsonKey(name: 'recommend')
  final ProductInfo? recommendInfo; // 為你推薦 - WEB/小網/APP (PS: 未登入時為 null)

  @JsonKey(name: 'social_media')
  final List<Service>? socialMedias; // 第三方 Social

  @JsonKey(name: 'new_goods')
  final ProductInfo newGoodsInfo; // 近七日新上架商品

  @JsonKey(name: 'bestsellers')
  final ProductInfo bestSellersInfo; // 近七日暢銷商品

  const MemberCenter(
      this.greeting,
      this.member,
      this.order,
      this.orderQA,
      this.noticeInfo,
      this.services,
      this.banners,
      this.favoriteInfo,
      this.browseInfo,
      this.boughtInfo,
      this.recommendInfo,
      this.socialMedias,
      this.newGoodsInfo,
      this.bestSellersInfo);

  factory MemberCenter.fromJson(Map<String, dynamic> json) =>
      _$MemberCenterFromJson(json);
  Map<String, dynamic> toJson() => _$MemberCenterToJson(this);
}

@JsonSerializable()
class Member {
  final Incomplete incomplete; // 會員資料的完整性
  final String? name;
  final String? mobile;
  final String? email;

  @JsonKey(name: 'login_times')
  final int loginTimes; // 登入次數
  final String online; // 會員等級啟用/停用狀態(YES=啟用,NO=停用)
  final int level; // 等級

  @JsonKey(name: 'level_point')
  final int? levelPoint; // 積分

  @JsonKey(name: 'level_setting')
  final List<LevelSetting> levelSettings; // 會員等級設定 + 等級說明

  @JsonKey(name: 'background_big_img_url')
  final String? backgroundBigImgUrl; // 會員等級背景圖片 大網用

  @JsonKey(name: 'background_small_img_url')
  final String? backgroundSmallImgUrl; // 會員等級背景圖片 小網用
  final int? coupon; // 折價券張數

  @JsonKey(name: 'max_level')
  final bool isMaxLevel; // 是否為最高等級

  @JsonKey(name: 'level_name')
  final String levelName; // 目前會員等級名稱

  @JsonKey(name: 'effect_eternal')
  final int? effectEternal; // 此等級是否永久生效

  @JsonKey(name: 'level_sdate')
  final String? levelStartDate; // 會員等級效期 - 開始 (null 為永久)

  @JsonKey(name: 'level_edate')
  final String? levelEndDate; // 會員等級效期 - 結束 (null 為永久)

  String get period {
    return levelStartDate == null && levelEndDate == null
        ? "有效期限：永久有效"
        : levelStartDate != null && levelEndDate == null
            ? "有效期限：$levelStartDate ~ 永久有效"
            : "";
  }

  @JsonKey(name: 'level_up_category_id')
  final int? levelUpCategoryId; // 升級條件

  @JsonKey(name: 'limit_level_up')
  final int limitLevelUp; // 距離升等還缺多少

  @JsonKey(name: 'next_level')
  final int? nextLevel; // 升級等級

  @JsonKey(name: 'next_level_name')
  final String nextLevelName; // 升級等級名稱

  String levelCategoryDescription(int limit) {
    switch (levelUpCategoryId) {
      case 1:
        return '單次消費滿 $limit 元';
      case 2:
        return '再消費滿 $limit 元';
      case 3:
        return '再消費滿 $limit 次';
    }
    return '';
  }

  String get nextLevelDescription {
    final description = levelCategoryDescription(limitLevelUp);
    return description.isEmpty
        ? '恭喜您，已升級至最高級會員！'
        : '$description, 就能升為$nextLevelName';
  }

  const Member(
      this.incomplete,
      this.name,
      this.mobile,
      this.email,
      this.loginTimes,
      this.online,
      this.level,
      this.levelPoint,
      this.levelSettings,
      this.backgroundBigImgUrl,
      this.backgroundSmallImgUrl,
      this.coupon,
      this.isMaxLevel,
      this.levelName,
      this.effectEternal,
      this.levelStartDate,
      this.levelEndDate,
      this.levelUpCategoryId,
      this.limitLevelUp,
      this.nextLevel,
      this.nextLevelName);

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable()
class Incomplete {
  final bool status; // true=不完整
  final String message; // 訊息

  const Incomplete(this.status, this.message);

  factory Incomplete.fromJson(Map<String, dynamic> json) =>
      _$IncompleteFromJson(json);
  Map<String, dynamic> toJson() => _$IncompleteToJson(this);
}

@JsonSerializable()
class LevelSetting {
  final int level; // 會員等級
  final String name; // 會員等級名稱
  final int? point; // 等級積分
  final String? image; // 會員徽章圖片位址

  @JsonKey(name: 'image_card')
  final String? imageCard; // 會員卡片圖片位址

  @JsonKey(name: 'effect_eternal')
  final int? effectEternal; // 是否永久有效

  @JsonKey(name: 'effect_interval')
  final int? effectInterval; // 會員效期

  @JsonKey(name: 'effect_interval_unit')
  final String? effectIntervalUnit; // 會員效期單位

  @JsonKey(name: 'level_up_category_id')
  final int? levelUpCategoryId; // 升等條件

  @JsonKey(name: 'limit_level_up')
  final int? limitLevelUp; // 升等條件 - 數值

  @JsonKey(name: 'level_keep_category_id')
  final int? levelKeepCategoryId; // 續等條件

  @JsonKey(name: 'limit_level_keep')
  final int? limitLevelKeep; // 續等條件 - 數值

  String get effectIntervalUnitString {
    switch (effectIntervalUnit) {
      case 'DAY':
        return '天';
      case 'MONTH':
        return '個月';
      case 'YEAR':
        return '年';
    }
    return '';
  }

  List<String> get levelConditionSpans {
    var formatter = NumberFormat("#,###");
    if (level == 0) {
      return ['完成會員註冊即可成為一般會員'];
    }
    switch (levelUpCategoryId) {
      case 1:
        return [
          '在$name期限內，單次消費購物金額滿',
          ' ${formatter.format(limitLevelUp)} ',
          '元'
        ];
      case 2:
        return [
          '在$name期限內，累計消費購物金額滿',
          ' ${formatter.format(limitLevelUp)} ',
          '元'
        ];
      case 3:
        return [
          '在$name期限內，單次消費購物次數滿',
          ' ${formatter.format(limitLevelUp)} ',
          '次'
        ];
    }
    return [];
  }

  List<String> get levelKeepConditionSpans {
    if (level == 0) {
      return ['-'];
    }
    var formatter = NumberFormat("#,###");
    switch (levelKeepCategoryId) {
      case 1:
        return [
          '在等級期限內，單次購物消費金額滿',
          ' ${formatter.format(limitLevelKeep)} ',
          '元'
        ];
      case 2:
        return [
          '在等級期限內，累積購物消費金額滿',
          ' ${formatter.format(limitLevelKeep)} ',
          '元'
        ];
      case 3:
        return ['在等級期限內，累積購物消費次數滿', ' $limitLevelKeep ', '次'];
    }
    return [];
  }

  String get levelPeriodDescription {
    switch (level) {
      case 0:
        return '永久';
    }
    return '$effectInterval $effectIntervalUnitString';
  }

  const LevelSetting(
      this.level,
      this.name,
      this.point,
      this.image,
      this.imageCard,
      this.effectEternal,
      this.effectInterval,
      this.effectIntervalUnit,
      this.levelUpCategoryId,
      this.limitLevelUp,
      this.levelKeepCategoryId,
      this.limitLevelKeep);

  factory LevelSetting.fromJson(Map<String, dynamic> json) =>
      _$LevelSettingFromJson(json);
  Map<String, dynamic> toJson() => _$LevelSettingToJson(this);
}

@JsonSerializable()
class Order {
  final int? total; // 我的訂單數量

  const Order(this.total);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderQA {
  final int? total; // 總問題數量
  final int? unread; // 未讀數量

  const OrderQA(this.total, this.unread);

  factory OrderQA.fromJson(Map<String, dynamic> json) =>
      _$OrderQAFromJson(json);
  Map<String, dynamic> toJson() => _$OrderQAToJson(this);
}

@JsonSerializable()
class NoticeInfo {
  final List<Unread>? unreads; // 未讀通知
  final int? total; // 最新通知list的筆數 (PS: 未登入時為 null)

  @JsonKey(name: 'list')
  final List<Notice?> notices; // 最新通知

  const NoticeInfo(this.unreads, this.total, this.notices);

  factory NoticeInfo.fromJson(Map<String, dynamic> json) =>
      _$NoticeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeInfoToJson(this);
}

@JsonSerializable()
class Unread {
  final int? unread; // 未讀
  final int? total; // 總筆數
  final String title; // 標題

  const Unread(this.unread, this.total, this.title);

  factory Unread.fromJson(Map<String, dynamic> json) => _$UnreadFromJson(json);
  Map<String, dynamic> toJson() => _$UnreadToJson(this);
}

@JsonSerializable()
class Notice {
  @JsonKey(name: 'notice_id')
  final int? noticeId; // 通知編號

  final String title; // 通知標題
  final String description; // 通知訊息

  @JsonKey(name: 'days_ago')
  final String daysAgo; // 多久前的訊息

  @JsonKey(name: 'image_url')
  final String imageUrl; // 圖示

  @JsonKey(name: 'link')
  final LinkType linkType;

  @JsonKey(name: 'link_data')
  final String linkValue;
  Link get link {
    return Link(linkType, linkValue);
  }

  @JsonKey(name: 'created_dt')
  final String createdAt; // 通知時間

  const Notice(this.noticeId, this.title, this.description, this.daysAgo,
      this.imageUrl, this.linkType, this.linkValue, this.createdAt);

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}

@JsonSerializable()
class Service {
  final String title; // 標題

  @JsonKey(name: 'enabled')
  final bool isEnabled; // true=開啟

  @JsonKey(name: 'link')
  final LinkType linkType;

  @JsonKey(name: 'link_data')
  final String linkValue;
  Link get link {
    return Link(linkType, linkValue);
  }

  const Service(
    this.title,
    this.isEnabled,
    this.linkType,
    this.linkValue,
  );

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}

extension ServiceIcon on Service {
  get icon {
    switch (linkType) {
      case LinkType.order:
        return 'icon_service_orderlist.png';
      case LinkType.bought:
        return 'icon_service_bought.png';
      case LinkType.cookie:
        return 'icon_service_cookie.png';
      case LinkType.updatemember:
        return 'icon_service_updatemember.png';
      case LinkType.fastcheckout:
        return 'icon_service_fastcheckout.png';
      case LinkType.orderqa:
        return 'icon_service_orderqa.png';
      case LinkType.service:
        return 'icon_service_service.png';
      case LinkType.membersetting:
        return 'icon_service_membersetting.png';
      default:
        return '';
    }
  }
}

@JsonSerializable()
class Banner {
  final String title; // 標題
  final String image; // 圖檔URL

  @JsonKey(name: 'link')
  final LinkType linkType;

  @JsonKey(name: 'link_data')
  final String linkValue;
  Link get link {
    return Link(linkType, linkValue);
  }

  const Banner(
    this.title,
    this.image,
    this.linkType,
    this.linkValue,
  );

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);
  Map<String, dynamic> toJson() => _$BannerToJson(this);
}

@JsonSerializable()
class FavoriteInfo {
  final int? total; // 收藏總數
  final List<Product?>? list;

  const FavoriteInfo(this.total, this.list);

  factory FavoriteInfo.fromJson(Map<String, dynamic> json) =>
      _$FavoriteInfoFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteInfoToJson(this);
}

@JsonSerializable()
class ProductInfo {
  final List<Product>? list;

  ProductInfo(this.list);

  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ProductInfoToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: 'goods_no')
  final String goodsNo; // 商品編號

  @JsonKey(name: 'image_url')
  final String? imageUrl; // 圖檔URL
  final String name; // 商品名稱

  @JsonKey(name: 'max_price')
  final int? maxPrice; // 最高價格

  @JsonKey(name: 'min_price')
  final int? minPrice; // 最低價格

  @JsonKey(name: 'is_favorite')
  final bool? isFavorite; // 是否有收藏

  const Product(this.goodsNo, this.imageUrl, this.name, this.maxPrice,
      this.minPrice, this.isFavorite);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
