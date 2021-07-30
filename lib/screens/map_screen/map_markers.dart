import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';

class MapMarkers extends ChangeNotifier {
  Set<Marker> _defaultMarkers;
  Set<Marker> _markers = <Marker>{};
  UnmodifiableSetView<Marker> get markers => UnmodifiableSetView(_markers);

  MapMarkers(
    MapItems mapItems,
    Function showCardFunc,
  ) {
    mapItems.mapItems.forEach((item) {
      Marker marker = _markerFromMapItem(item, showCardFunc);
      _defaultMarkers.add(marker);
    });
    _markers = _defaultMarkers;
  }

  Marker _markerFromMapItem(MapItem mapItem, Function showCardFunc) {
    MarkerId markerId = MarkerId(mapItem.name);
    Marker marker = Marker(
      //icon: _iconType(mapItem.type),
      markerId: markerId,
      position: LatLng(
        mapItem.geoLocation.lat,
        mapItem.geoLocation.lon,
      ),
      onTap: () {
        showCardFunc(mapItem);
      },
    );
    return marker;
  }
}
