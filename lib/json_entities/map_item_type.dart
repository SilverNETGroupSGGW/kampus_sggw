import 'package:json_annotation/json_annotation.dart';

part 'map_item_type.g.dart';

@JsonSerializable()
class MapItemType {
  String name;
  String materialIconName;
  @JsonKey(defaultValue: 'otherMarker.png')
  String pinIconPath;

  MapItemType({
    required this.name,
    required this.materialIconName,
    required this.pinIconPath,
  });

  factory MapItemType.fromJson(Map<String, dynamic> json) =>
      _$MapItemTypeFromJson(json);
}
