import 'package:json_annotation/json_annotation.dart';

import '../../../data/helper/json_value_converter.dart';
import '../link.dart';

part 'image_list_item.g.dart';

enum ImageListItemSize {
  @JsonValue('S') small,
  @JsonValue('M') medium,
  @JsonValue('L') large
}
extension ImageListItemSizeExt on ImageListItemSize {
  double get ratio {
    switch (this) {
      case ImageListItemSize.small: return 195.0/750.0;
      case ImageListItemSize.medium: return 290.0/750.0;
      case ImageListItemSize.large: return 390.0/750.0;
      default: return 0.0;

    }
  } 
}
@JsonSerializable()
class ImageListItem {
  ImageListItem(this.image, this.linkType, this.linkValue, this.enabled);

  @JsonKey(name: 'img')
  @JsonKey(name: 'sub_img')
  String image;
  String? title;
  String? content;
  bool get contentNotEmpty => (content != null && content!.isNotEmpty);
  @JsonKey(name: 'sub_sdate')
  DateTime? start;
  @JsonKey(name: 'sub_edate')
  DateTime? end;
  @JsonKey(name: 'sub_link')
  LinkType linkType;
  @JsonKey(name:'sub_link_data')
  String linkValue;
  Link get link {
    return Link(linkType, linkValue);
  }
  @JsonKey(name: 'sub_enable', fromJson: JsonValueConverter.boolFromInt, toJson: JsonValueConverter.boolToInt)
  bool enabled;

  factory ImageListItem.fromJson(Map<String, dynamic> json) => _$ImageListItemFromJson(json);
  Map<String, dynamic> toJson() => _$ImageListItemToJson(this);
}