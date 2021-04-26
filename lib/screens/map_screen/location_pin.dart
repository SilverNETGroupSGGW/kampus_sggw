import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/map.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/point.dart';

class LocationPin extends StatelessWidget {
  // Pin position on the map, (-1, 1) range
  double x;
  double y;
  double scale;
  Map map;

  MapItem mapItem;
  Function(MapItem mapItem) onPress;

  // Constructors
  LocationPin.fromMapItem(this.mapItem, this.onPress, this.map) {
    Point point = map.geoLocationToMapPoint(mapItem.geoLocation);
    this.x = point.x;
    this.y = point.y;
    this.scale = 1.0;
  }
  LocationPin.withNewScale(LocationPin pin, double newScale, this.map) {
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
}
