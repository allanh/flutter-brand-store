import 'package:json_annotation/json_annotation.dart';

import '../../../data/helper/json_value_converter.dart';
import 'ad_item.dart';
import 'product_list_item.dart';
import '../link.dart';

part 'module.g.dart';

enum ModuleType {
  @JsonValue('prod')
  product,
  @JsonValue('ad')
  ad,
  @JsonValue('video')
  video,
}
enum DisplayMode {
  @JsonValue('SCROLL')
  scroll,
  @JsonValue('NOSCROLL')
  expand,
}

@JsonSerializable()
class Module {
  Module(this.type, this.layoutID, this.templateID, this.mainID, this.showTitle,
      this.title);

  @JsonKey(name: 'module_type')
  ModuleType type;
  @JsonKey(name: 'layout_id')
  int layoutID;
  @JsonKey(name: 'template_id')
  int templateID;
  @JsonKey(name: 'main_id')
  int mainID;
  @JsonKey(
      name: 'show_module_title',
      fromJson: JsonValueConverter.boolFromString,
      toJson: JsonValueConverter.boolToString)
  bool showTitle;
  @JsonKey(name: 'module_title')
  String title;
  // products
  @JsonKey(name: 'prod_limit')
  int? limit;
  @JsonKey(
      name: 'show_prodname',
      fromJson: JsonValueConverter.boolFromString,
      toJson: JsonValueConverter.boolToString)
  bool? showProductName;
  @JsonKey(
      name: 'show_prodprice',
      fromJson: JsonValueConverter.boolFromString,
      toJson: JsonValueConverter.boolToString)
  bool? showProductPrice;
  @JsonKey(name: 'prod_list')
  List<ProductListItem>? products;
  // ads
  @JsonKey(name: 'ref_module_id')
  int? referModulrID;
  @JsonKey(name: 'img_size')
  ImageListItemSize? size;
  @JsonKey(name: 'img_list')
  List<ImageListItem>? images;
  @JsonKey(name: 'show_mode')
  DisplayMode? mode;
  @JsonKey(name: 'list')
  List<AdItem>? marquees;
  @JsonKey(name: 'sub_youtube_url')
  String? youtubeUrl;

  @JsonKey(name: 'sub_title')
  String? youtubeTitle;
  @JsonKey(
      name: 'show_sub_title',
      fromJson: JsonValueConverter.boolFromString,
      toJson: JsonValueConverter.boolToString)
  bool? showYuotubeTitle;
  @JsonKey(name: 'sub_link')
  LinkType? linkType;
  @JsonKey(name: 'sub_link_data')
  String? linkValue;
  Link get youtube => Link(linkType ?? LinkType.none, linkValue ?? '');
  bool get contentNotEmpty => (images != null &&
      images!.where((element) => element.contentNotEmpty).toList().isNotEmpty);
  bool get isMarquee => type == ModuleType.ad && templateID == 3;
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

  factory ModuleList.fromJson(Map<String, dynamic> json) =>
      _$ModuleListFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleListToJson(this);
}
