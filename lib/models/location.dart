import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

@JsonSerializable()
class Location {
  double? lat;
  double? lon;
  Location(this.lat, this.lon);
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
