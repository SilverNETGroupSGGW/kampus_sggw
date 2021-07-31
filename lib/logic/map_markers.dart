import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampus_sggw/logic/map_controller.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/logic/marker_type_enum.dart';

class MapMarkers extends ChangeNotifier {
  Set<Marker> _default;
  Set<Marker> _markers;
  Map<MarkerTypeEnum, BitmapDescriptor> _bitmapDescriptors;
  MapController _controllerProvider;

  UnmodifiableSetView<Marker> get markers => UnmodifiableSetView(_markers);

  MapMarkers({
    MapController mapController,
  }) {
    _controllerProvider = mapController;
    _default = {};
    _bitmapDescriptors = <MarkerTypeEnum, BitmapDescriptor>{};
  }

  void resetMarkers() {
    _markers = _default;
    notifyListeners();
  }

  Future<void> initializeIcons() async {
    addBitmapDescriptor(
      MarkerTypeEnum.facultyMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/facultyMarker.png'),
    );

    addBitmapDescriptor(
      MarkerTypeEnum.sportMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/sportMarker.png'),
    );

    addBitmapDescriptor(
      MarkerTypeEnum.administrationMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/administrationMarker.png'),
    );

    addBitmapDescriptor(
      MarkerTypeEnum.hotelMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/hotelMarker.png'),
    );

    addBitmapDescriptor(
      MarkerTypeEnum.storeMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/storeMarker.png'),
    );

    addBitmapDescriptor(
      MarkerTypeEnum.foodMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/foodMarker.png'),
    );

    addBitmapDescriptor(
      MarkerTypeEnum.libraryMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/libraryMarker.png'),
    );

    addBitmapDescriptor(
      MarkerTypeEnum.parkingMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/parkingMarker.png'),
    );

    addBitmapDescriptor(
      MarkerTypeEnum.transportMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/transportMarker.png'),
    );

    addBitmapDescriptor(
      MarkerTypeEnum.financeMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/financeMarker.png'),
    );
    print("waited");

    addBitmapDescriptor(
      MarkerTypeEnum.otherMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/otherMarker.png'),
    );

    print("waited");
  }

  void updateMarkers(List<MapItem> filteredItems) {
    _filterMarkers(filteredItems);
    _controllerProvider.zoomInto(_markers.first);
    notifyListeners();
  }

  void addBitmapDescriptor(MarkerTypeEnum markerType, BitmapDescriptor icon) {
    _bitmapDescriptors[markerType] = icon;
  }

  void initializeDefaultMarkers(MapItems mapItems, Function showCardFunc) {
    mapItems.mapItems.forEach((item) {
      Marker marker = _markerFromMapItem(item, showCardFunc);
      _default.add(marker);
    });
    print("BitmapDescriptors " + _bitmapDescriptors.length.toString());
    _markers = _default;
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
      icon: _iconType(mapItem.type),
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

  BitmapDescriptor _iconType(MapItemType type) {
    if (type == MapItemType.facultyBuilding) {
      return _bitmapDescriptors[MarkerTypeEnum.facultyMarker];
    }

    if (type == MapItemType.administrationBuilding) {
      return _bitmapDescriptors[MarkerTypeEnum.administrationMarker];
    }

    if (type == MapItemType.dormitories)
      return _bitmapDescriptors[MarkerTypeEnum.hotelMarker];

    if (type == MapItemType.sportsFacility)
      return _bitmapDescriptors[MarkerTypeEnum.sportMarker];

    if (type == MapItemType.finance)
      return _bitmapDescriptors[MarkerTypeEnum.financeMarker];

    if (type == MapItemType.food)
      return _bitmapDescriptors[MarkerTypeEnum.foodMarker];

    if (type == MapItemType.library)
      return _bitmapDescriptors[MarkerTypeEnum.libraryMarker];

    if (type == MapItemType.parking)
      return _bitmapDescriptors[MarkerTypeEnum.parkingMarker];

    if (type == MapItemType.store)
      return _bitmapDescriptors[MarkerTypeEnum.storeMarker];

    if (type == MapItemType.transport)
      return _bitmapDescriptors[MarkerTypeEnum.transportMarker];

    return _bitmapDescriptors[MarkerTypeEnum.otherMarker];
  }
}
