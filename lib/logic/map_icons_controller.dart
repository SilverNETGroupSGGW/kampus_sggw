import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampus_sggw/logic/marker_type_enum.dart';
import 'package:kampus_sggw/models/map_item.dart';

class MapIconsController {
  Map<MarkerTypeEnum, BitmapDescriptor> _bitmapDescriptors;

  MapIconsController() {
    _bitmapDescriptors = <MarkerTypeEnum, BitmapDescriptor>{};
  }

  static Future<MapIconsController> loadIcons() async {
    MapIconsController iconsController = MapIconsController();
    await iconsController._initializeIcons();
    return iconsController;
  }

  BitmapDescriptor mapIcon(MapItemType type) {
    if (type == MapItemType.facultyBuilding)
      return _bitmapDescriptors[MarkerTypeEnum.facultyMarker];

    if (type == MapItemType.administrationBuilding)
      return _bitmapDescriptors[MarkerTypeEnum.administrationMarker];

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

  Future<void> _initializeIcons() async {
    String dirName = _getIconsDir();

    _addBitmapDescriptor(
      MarkerTypeEnum.facultyMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(30, 45),
          ),
          dirName + 'facultyMarker.png'),
    );

    _addBitmapDescriptor(
      MarkerTypeEnum.sportMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(30, 45),
          ),
          dirName + 'sportMarker.png'),
    );

    _addBitmapDescriptor(
      MarkerTypeEnum.administrationMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(30, 45),
          ),
          dirName + 'administrationMarker.png'),
    );

    _addBitmapDescriptor(
      MarkerTypeEnum.hotelMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(30, 45),
          ),
          dirName + 'hotelMarker.png'),
    );

    _addBitmapDescriptor(
      MarkerTypeEnum.storeMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(30, 45),
          ),
          dirName + 'storeMarker.png'),
    );

    _addBitmapDescriptor(
      MarkerTypeEnum.foodMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(30, 45),
          ),
          dirName + 'foodMarker.png'),
    );

    _addBitmapDescriptor(
      MarkerTypeEnum.libraryMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(30, 45),
          ),
          dirName + 'libraryMarker.png'),
    );

    _addBitmapDescriptor(
      MarkerTypeEnum.parkingMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(30, 45),
          ),
          dirName + 'parkingMarker.png'),
    );

    _addBitmapDescriptor(
      MarkerTypeEnum.transportMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(30, 45),
          ),
          dirName + 'transportMarker.png'),
    );

    _addBitmapDescriptor(
      MarkerTypeEnum.financeMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(30, 45),
          ),
          dirName + 'financeMarker.png'),
    );

    _addBitmapDescriptor(
      MarkerTypeEnum.otherMarker,
      await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(30, 45),
          ),
          dirName + 'otherMarker.png'),
    );
  }

  void _addBitmapDescriptor(MarkerTypeEnum markerType, BitmapDescriptor icon) {
    _bitmapDescriptors[markerType] = icon;
  }

  String _getIconsDir() =>
      _isPlatformMobile() ? _getDirBasedOnPlatform() : 'assets/images/icons/';

  String _getDirBasedOnPlatform() =>
      Platform.isAndroid ? 'assets/images/icons/' : 'assets/images/icons/ios_';

  bool _isPlatformMobile() {
    try {
      return Platform.isAndroid || Platform.isIOS;
    } catch (e) {
      return false;
    }
  }
}
