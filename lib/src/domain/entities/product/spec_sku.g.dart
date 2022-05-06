// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spec_sku.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecSku _$SpecSkuFromJson(Map<String, dynamic> json) => SpecSku(
      level: json['level'] as int?,
      specName: json['spec_name'] as String?,
      imageUrl: json['image_url'] as String?,
      specLv1Id: json['spec_lv_1_id'] as int?,
      specLv1Name: json['spec_lv_1_name'] as String?,
      specImageUrl: json['spec_image_url'] as String?,
      sku: json['sku'] == null
          ? null
          : Sku.fromJson(json['sku'] as Map<String, dynamic>),
      spec2: (json['spec_2'] as List<dynamic>?)
          ?.map((e) => SpecSku.fromJson(e as Map<String, dynamic>))
          .toList(),
      specLv2Id: json['spec_lv_2_id'] as int?,
      specLv2Name: json['spec_lv_2_name'] as String?,
      isProduct: json['is_product'] as bool?,
    );

Map<String, dynamic> _$SpecSkuToJson(SpecSku instance) => <String, dynamic>{
      'level': instance.level,
      'spec_name': instance.specName,
      'image_url': instance.imageUrl,
      'spec_lv_1_id': instance.specLv1Id,
      'spec_lv_1_name': instance.specLv1Name,
      'spec_image_url': instance.specImageUrl,
      'sku': instance.sku,
      'spec_2': instance.spec2,
      'spec_lv_2_id': instance.specLv2Id,
      'spec_lv_2_name': instance.specLv2Name,
      'is_product': instance.isProduct,
    };

Sku _$SkuFromJson(Map<String, dynamic> json) => Sku(
      productId: json['product_id'] as int?,
      productNo: json['product_no'] as String?,
      productName: json[' product_name'] as String?,
      imageUrl: json['image_url'] as String?,
      quantity: json['quantity'] as int?,
      saleLimit: json['sale_limit'] as int?,
      proposedPrice: json['proposed_price'] as int?,
    );

Map<String, dynamic> _$SkuToJson(Sku instance) => <String, dynamic>{
      'product_id': instance.productId,
      'product_no': instance.productNo,
      ' product_name': instance.productName,
      'image_url': instance.imageUrl,
      'quantity': instance.quantity,
      'sale_limit': instance.saleLimit,
      'proposed_price': instance.proposedPrice,
    };
