import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/map_item.dart';

class LocationPin extends StatelessWidget {
  // Lat/lon positions of the map
  double _minLat = 52.15625;
  double _maxLat = 52.16538;
  double _minLon = 21.03724;
  double _maxLon = 21.05215;

  // Pin position on the map, (-1, 1) range
  double x;
  double y;
  double scale;

  MapItem mapItem;
  Function(MapItem mapItem) onPress;

  // Constructors
  LocationPin.fromMapItem(this.mapItem, this.onPress) {
    this.x = _lonToPos(mapItem.geoLocation.lon);
    this.y = _latToPos(mapItem.geoLocation.lat);
    this.scale = 1.0;
  }
  LocationPin.withNewScale(LocationPin pin, double newScale) {
    this.x = pin.x;
    this.y = pin.y;
    this.mapItem = pin.mapItem;
    this.onPress = pin.onPress;

    this.scale = newScale;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(x, y),
      child: IconButton(
        icon: Icon(Icons.location_on, color: Colors.red),
        iconSize: 50 / scale,
        onPressed: _iconPressed,
      ),
    );
  }

  void _iconPressed() {
    onPress(mapItem);
  }

  double _latToPos(double lat) => _remapRange(lat, _minLat, _maxLat, 1, -1);
  double _lonToPos(double lon) => _remapRange(lon, _minLon, _maxLon, -1, 1);

  double _remapRange(
      double v, double inA, double inB, double outA, double outB) {
    return (v - inA) / (inB - inA) * (outB - outA) + outA;
  }
}