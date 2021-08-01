import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampus_sggw/logic/map_controller.dart';
import 'package:kampus_sggw/logic/map_icons_controller.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';

class MapMarkersConroller extends ChangeNotifier {
  Set<Marker> _default;
  Set<Marker> _markers;
  MapController _controllerProvider;
  MapIconsController _iconsController;

  UnmodifiableSetView<Marker> get markers => UnmodifiableSetView(_markers);

  MapMarkersConroller(
      {MapController mapController, MapIconsController iconsController}) {
    _controllerProvider = mapController;
    _iconsController = iconsController;
    _default = {};
  }

  void resetMarkers() {
    _markers = _default;
    notifyListeners();
  }

  void initializeDefaultMarkers(MapItems mapItems, Function showCardFunc) {
    mapItems.mapItems.forEach((item) {
      Marker marker = _markerFromMapItem(item, showCardFunc);
      _default.add(marker);
    });
    _markers = _default;
  }

  void updateMarkers(List<MapItem> filteredItems) {
    _filterMarkers(filteredItems);
    _controllerProvider.zoomInto(_markers.first);
    notifyListeners();
  }

  void _filterMarkers(List<MapItem> filteredItems) {
    _markers = {};
    filteredItems.forEach((item) {
      Marker marker = _default.firstWhere((marker) =>
          marker.markerId == MarkerId(item.name + item.id.toString()));
      _markers.add(marker);
    });
  }

  Marker _markerFromMapItem(MapItem mapItem, Function showCardFunc) {
    MarkerId markerId = MarkerId(mapItem.name + mapItem.id.toString());
    Marker marker = Marker(
      icon: _iconsController.mapIcon(mapItem.type),
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
