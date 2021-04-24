import 'package:kampus_sggw/models/location.dart';
import 'package:kampus_sggw/models/point.dart';
class Map {
  Location bottomLeftCorner;
  Location topRightCorner;
  Map({this.bottomLeftCorner, this.topRightCorner});
  Point geoLocationToMapPoint(Location geoLocation) {
    //TODO
  }
}
