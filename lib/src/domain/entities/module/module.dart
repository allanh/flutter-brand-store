import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../data/helper/json_value_converter.dart';
import '../link.dart';
import 'image_list_item.dart';

part 'module.g.dart';

enum ModuleType {
  @JsonValue('prod') product,
  @JsonValue('ad') ad,
}

@JsonSerializable()
class ModuleItem {
  ModuleItem(this.image, this.name, this.price, this.recommend, this.link);

  @JsonKey(name: 'prod_image')
  String? image;
  @JsonKey(name: 'prod_name')
  String name;
  @JsonKey(name: 'prod_price')
  int price;
  @JsonKey(name: 'prod_recom')
  String? recommend;
  Link link;

  factory ModuleItem.fromJson(Map<String, dynamic> json) => _$ModuleItemFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleItemToJson(this);

}

@JsonSerializable()
class Module {
  Module(this.type, this.layoutID, this.templateID, this.mainID, this.showTitle, this.title);

  @JsonKey(name: 'module_type')
  ModuleType type;
  @JsonKey(name: 'layout_id')
  int layoutID;
  @JsonKey(name: 'template_id')
  int templateID;
  @JsonKey(name: 'main_id')
  int mainID;
  @JsonKey(name: 'show_module_title', fromJson: JsonValueConverter.boolFromString, toJson: JsonValueConverter.boolToString)
  bool showTitle;
  @JsonKey(name: 'module_title')
  String title;
  // products
  @JsonKey(name: 'prod_limit')
  int? limit;
  @JsonKey(name: 'show_prodname', fromJson: JsonValueConverter.boolFromString, toJson: JsonValueConverter.boolToString)
  bool? showProductName;
  @JsonKey(name: 'show_prodprice', fromJson: JsonValueConverter.boolFromString, toJson: JsonValueConverter.boolToString)
  bool? showProductPrice;
  @JsonKey(name:'prod_list')
  List<ModuleItem>? products;
  // ads
  @JsonKey(name: 'ref_module_id')
  int? referModulrID;
  @JsonKey(name: 'img_size')
  ImageListItemSize? size;
  @JsonKey(name:'img_list')
  List<ImageListItem>? images;
  bool get contentNotEmpty => (images != null && images!.where((element) => element.contentNotEmpty).toList().isNotEmpty);
  final PageController _controller = PageController();
  PageController get controller => _controller;
  @JsonKey(ignore: true)
  int selectedIndex = 0;
  bool get hasChild {
    if (type == ModuleType.product) {
      return (products != null && ((products?.length ?? 0) > 0));
    } else if (type == ModuleType.ad) {
      return (images != null && ((images?.length ?? 0) > 0));
    }
    return false;
  } 
  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}

@JsonSerializable()
class ModuleList {
  ModuleList(this.layoutID, this.modules);

  @JsonKey(name: 'layout_id')
  int layoutID;
  @JsonKey(name: 'result')
  List<Module> modules;

  List<Module> get goodModules {
    return modules.where((element) => element.hasChild).toList();
  }
  factory ModuleList.fromJson(Map<String, dynamic> json) => _$ModuleListFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleListToJson(this);
}