// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_center.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberCenterResponse _$MemberCenterResponseFromJson(
        Map<String, dynamic> json) =>
    MemberCenterResponse(
      json['id'] as String,
      json['status'] as String,
      json['message'] as String?,
      MemberCenter.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemberCenterResponseToJson(
        MemberCenterResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'message': instance.message,
      'data': instance.memberCenter,
    };

MemberCenter _$MemberCenterFromJson(Map<String, dynamic> json) => MemberCenter(
      json['greeting'] as String,
      json['member'] == null
          ? null
          : Member.fromJson(json['member'] as Map<String, dynamic>),
      json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
      json['order_qa'] == null
          ? null
          : OrderQA.fromJson(json['order_qa'] as Map<String, dynamic>),
      json['notice'] == null
          ? null
          : NoticeInfo.fromJson(json['notice'] as Map<String, dynamic>),
      (json['service'] as List<dynamic>)
          .map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['banner'] as List<dynamic>)
          .map((e) => Banner.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['favorite'] == null
          ? null
          : FavoriteInfo.fromJson(json['favorite'] as Map<String, dynamic>),
      json['browse'] == null
          ? null
          : ProductInfo.fromJson(json['browse'] as Map<String, dynamic>),
      json['bought'] == null
          ? null
          : ProductInfo.fromJson(json['bought'] as Map<String, dynamic>),
      json['recommend'] == null
          ? null
          : ProductInfo.fromJson(json['recommend'] as Map<String, dynamic>),
      (json['social_media'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      ProductInfo.fromJson(json['new_goods'] as Map<String, dynamic>),
      ProductInfo.fromJson(json['bestsellers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemberCenterToJson(MemberCenter instance) =>
    <String, dynamic>{
      'greeting': instance.greeting,
      'member': instance.member,
      'order': instance.order,
      'order_qa': instance.orderQA,
      'notice': instance.noticeInfo,
      'service': instance.services,
      'banner': instance.banners,
      'favorite': instance.favoriteInfo,
      'browse': instance.browseInfo,
      'bought': instance.boughtInfo,
      'recommend': instance.recommendInfo,
      'social_media': instance.socialMedias,
      'new_goods': instance.newGoodsInfo,
      'bestsellers': instance.bestSellersInfo,
    };

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      Incomplete.fromJson(json['incomplete'] as Map<String, dynamic>),
      json['name'] as String?,
      json['mobile'] as String?,
      json['email'] as String?,
      json['login_times'] as int,
      json['online'] as String,
      json['level'] as int,
      json['level_point'] as int?,
      (json['level_setting'] as List<dynamic>)
          .map((e) => LevelSetting.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['background_big_img_url'] as String?,
      json['background_small_img_url'] as String?,
      json['coupon'] as int?,
      json['max_level'] as bool,
      json['level_name'] as String,
      json['effect_eternal'] as int?,
      json['level_sdate'] as String?,
      json['level_edate'] as String?,
      json['level_up_category_id'] as int?,
      json['limit_level_up'] as int,
      json['next_level'] as int?,
      json['next_level_name'] as String,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'incomplete': instance.incomplete,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'login_times': instance.loginTimes,
      'online': instance.online,
      'level': instance.level,
      'level_point': instance.levelPoint,
      'level_setting': instance.levelSettings,
      'background_big_img_url': instance.backgroundBigImgUrl,
      'background_small_img_url': instance.backgroundSmallImgUrl,
      'coupon': instance.coupon,
      'max_level': instance.isMaxLevel,
      'level_name': instance.levelName,
      'effect_eternal': instance.effectEternal,
      'level_sdate': instance.levelStartDate,
      'level_edate': instance.levelEndDate,
      'level_up_category_id': instance.levelUpCategoryId,
      'limit_level_up': instance.limitLevelUp,
      'next_level': instance.nextLevel,
      'next_level_name': instance.nextLevelName,
    };

Incomplete _$IncompleteFromJson(Map<String, dynamic> json) => Incomplete(
      json['status'] as bool,
      json['message'] as String,
    );

Map<String, dynamic> _$IncompleteToJson(Incomplete instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

LevelSetting _$LevelSettingFromJson(Map<String, dynamic> json) => LevelSetting(
      json['level'] as int,
      json['name'] as String,
      json['point'] as int?,
      json['image'] as String?,
      json['image_card'] as String?,
      json['effect_eternal'] as int?,
      json['effect_interval'] as int?,
      json['effect_interval_unit'] as String?,
      json['level_up_category_id'] as int?,
      json['limit_level_up'] as int?,
      json['level_keep_category_id'] as int?,
      json['limit_level_keep'] as int?,
    );

Map<String, dynamic> _$LevelSettingToJson(LevelSetting instance) =>
    <String, dynamic>{
      'level': instance.level,
      'name': instance.name,
      'point': instance.point,
      'image': instance.image,
      'image_card': instance.imageCard,
      'effect_eternal': instance.effectEternal,
      'effect_interval': instance.effectInterval,
      'effect_interval_unit': instance.effectIntervalUnit,
      'level_up_category_id': instance.levelUpCategoryId,
      'limit_level_up': instance.limitLevelUp,
      'level_keep_category_id': instance.levelKeepCategoryId,
      'limit_level_keep': instance.limitLevelKeep,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['total'] as int?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'total': instance.total,
    };

OrderQA _$OrderQAFromJson(Map<String, dynamic> json) => OrderQA(
      json['total'] as int?,
      json['unread'] as int?,
    );

Map<String, dynamic> _$OrderQAToJson(OrderQA instance) => <String, dynamic>{
      'total': instance.total,
      'unread': instance.unread,
    };

NoticeInfo _$NoticeInfoFromJson(Map<String, dynamic> json) => NoticeInfo(
      (json['unreads'] as List<dynamic>?)
          ?.map((e) => Unread.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int?,
      (json['list'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Notice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NoticeInfoToJson(NoticeInfo instance) =>
    <String, dynamic>{
      'unreads': instance.unreads,
      'total': instance.total,
      'list': instance.notices,
    };

Unread _$UnreadFromJson(Map<String, dynamic> json) => Unread(
      json['unread'] as int?,
      json['total'] as int?,
      json['title'] as String,
    );

Map<String, dynamic> _$UnreadToJson(Unread instance) => <String, dynamic>{
      'unread': instance.unread,
      'total': instance.total,
      'title': instance.title,
    };

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice(
      json['notice_id'] as int?,
      json['title'] as String,
      json['description'] as String,
      json['days_ago'] as String,
      json['image_url'] as String,
      $enumDecode(_$LinkTypeEnumMap, json['link']),
      json['link_data'] as String,
      json['created_dt'] as String,
    );

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'notice_id': instance.noticeId,
      'title': instance.title,
      'description': instance.description,
      'days_ago': instance.daysAgo,
      'image_url': instance.imageUrl,
      'link': _$LinkTypeEnumMap[instance.linkType],
      'link_data': instance.linkValue,
      'created_dt': instance.createdAt,
    };

const _$LinkTypeEnumMap = {
  LinkType.none: '',
  LinkType.product: 'product',
  LinkType.url: 'inputurl',
  LinkType.category: 'selcategory',
  LinkType.categoryView: 'selcategoryview',
  LinkType.neweventview: 'neweventview',
  LinkType.cart: 'cart',
  LinkType.order: 'orderlist',
  LinkType.favorite: 'favorite',
  LinkType.bought: 'bought',
  LinkType.cookie: 'cookie',
  LinkType.updatemember: 'updatemember',
  LinkType.fastcheckout: 'fastcheckout',
  LinkType.orderqa: 'orderqa',
  LinkType.service: 'service',
  LinkType.membersetting: 'membersetting',
  LinkType.orderdetail: 'orderdetail',
  LinkType.allEvent: 'newevent',
  LinkType.event: 'neweventview',
};

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      json['title'] as String,
      json['enabled'] as bool,
      $enumDecode(_$LinkTypeEnumMap, json['link']),
      json['link_data'] as String,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'title': instance.title,
      'enabled': instance.isEnabled,
      'link': _$LinkTypeEnumMap[instance.linkType],
      'link_data': instance.linkValue,
    };

Banner _$BannerFromJson(Map<String, dynamic> json) => Banner(
      json['title'] as String,
      json['image'] as String,
      $enumDecode(_$LinkTypeEnumMap, json['link']),
      json['link_data'] as String,
    );

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
      'link': _$LinkTypeEnumMap[instance.linkType],
      'link_data': instance.linkValue,
    };

FavoriteInfo _$FavoriteInfoFromJson(Map<String, dynamic> json) => FavoriteInfo(
      json['total'] as int?,
      (json['list'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteInfoToJson(FavoriteInfo instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list,
    };

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) => ProductInfo(
      (json['list'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['goods_no'] as String,
      json['image_url'] as String?,
      json['name'] as String,
      json['max_price'] as int?,
      json['min_price'] as int?,
      json['is_favorite'] as bool?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'goods_no': instance.goodsNo,
      'image_url': instance.imageUrl,
      'name': instance.name,
      'max_price': instance.maxPrice,
      'min_price': instance.minPrice,
      'is_favorite': instance.isFavorite,
    };
