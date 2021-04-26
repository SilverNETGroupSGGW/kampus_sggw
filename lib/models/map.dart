import 'package:kampus_sggw/models/location.dart';
import 'package:kampus_sggw/models/point.dart';

class Map {
  Location bottomRightCorner;
  Location topLeftCorner;
  double minScale;
  double maxScale;
  Map({
    this.bottomRightCorner,
    this.topLeftCorner,
    this.minScale,
    this.maxScale,
  });

  Point geoLocationToMapPoint(Location geoLocation) {
    double latToPos = remapRange(
        geoLocation.lat, bottomRightCorner.lat, topLeftCorner.lat, 1, -1);
    double lonToPos = remapRange(
        geoLocation.lon, topLeftCorner.lon, bottomRightCorner.lon, -1, 1);
    return new Point(x: lonToPos, y: latToPos);
  }

  double remapRange(
      double v, double inA, double inB, double outA, double outB) {
    return (v - inA) / (inB - inA) * (outB - outA) + outA;
  }
}
