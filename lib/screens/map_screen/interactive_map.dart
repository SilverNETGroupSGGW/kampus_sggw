import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampus_sggw/logic/search_services/markers_service.dart';
import 'package:kampus_sggw/logic/histories/visit_history.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/models/map_settings.dart';
import 'package:kampus_sggw/logic/map_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:provider/provider.dart';

class InteractiveMap extends StatefulWidget {
  //final TransformationController transController = TransformationController();
  final Function showCard;
  final mapSettings = MapSettings(
    cameraTargetBounds: CameraTargetBounds(
      LatLngBounds(
        southwest: LatLng(52.14848842369187, 21.026785217862553),
        northeast: LatLng(52.17391386567901, 21.06859758021918),
      ),
    ),
    initialCameraPosition: CameraPosition(
      target: LatLng(52.162012883882326, 21.046311475278525),
      tilt: 0,
      zoom: 16,
    ),
    minMaxZoomPreference: MinMaxZoomPreference(15, 19),
  );

  InteractiveMap({
    @required this.showCard,
  });

  @override
  _InteractiveMapState createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> with ChangeNotifier {
  MapItems _mapItems;
  Map markers = <MarkerId, Marker>{};
  GoogleMap _googleMap;
  Set<Marker> _currentMarkerSet = <Marker>{};
  StreamSubscription _filterMarkers;
  StreamSubscription _unfilterMarkers;
  BitmapDescriptor facultyMarker;
  BitmapDescriptor sportMarker;
  BitmapDescriptor otherMarker;
  BitmapDescriptor hotelMarker;
  BitmapDescriptor administrationMarker;
  BitmapDescriptor storeMarker;
  BitmapDescriptor foodMarker;
  BitmapDescriptor libraryMarker;
  BitmapDescriptor parkingMarker;
  BitmapDescriptor transportMarker;
  BitmapDescriptor financeMarker;

  @override
  initState() {
    _mapItems = Provider.of<MapItems>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      facultyMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/facultyMarker.png');

      sportMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/sportMarker.png');

      administrationMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/administrationMarker.png');

      hotelMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/hotelMarker.png');

      storeMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/storeMarker.png');

      foodMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/foodMarker.png');

      libraryMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/libraryMarker.png');

      parkingMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/parkingMarker.png');

      transportMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/transportMarker.png');

      financeMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/financeMarker.png');

      otherMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(30, 45)),
          'assets/images/icons/otherMarker.png');

      setState(() {});

      tryRequestLocation();
      _setMarkers(markers, _mapItems.mapItems);
      _currentMarkerSet = markers.values.toSet();
      MarkersService markersService =
          Provider.of<MarkersService>(context, listen: false);
      _filterMarkers = markersService.filterEvent
          .listen((eventParam) => _updateMarkers(eventParam.filteredMapItems));
      _unfilterMarkers =
          markersService.unfilterEvent.listen((_) => _updateMarkersToDefault());
    });

    super.initState();
  }

  @override
  dispose() {
    _filterMarkers.cancel();
    _unfilterMarkers.cancel();
    super.dispose();
  }

  void _setMarkers(Map markersMap, List<MapItem> mapItems) {
    mapItems.forEach((mapItem) {
      Marker marker = _getMarkerFromMapItem(mapItem);
      markersMap[marker.markerId] = marker;
    });
  }

  Marker _getMarkerFromMapItem(MapItem mapItem) {
    MarkerId markerId = MarkerId(mapItem.name + mapItem.id.toString());
    Marker marker = Marker(
      icon: _iconType(mapItem.type),
      markerId: markerId,
      position: LatLng(
        mapItem.geoLocation.lat,
        mapItem.geoLocation.lon,
      ),
      onTap: () {
        _onPinPressed(mapItem);
      },
    );
    return marker;
  }

  BitmapDescriptor _iconType(MapItemType type) {
    if (type == MapItemType.facultyBuilding) return facultyMarker;

    if (type == MapItemType.administrationBuilding) return administrationMarker;

    if (type == MapItemType.dormitories) return hotelMarker;

    if (type == MapItemType.sportsFacility) return sportMarker;

    if (type == MapItemType.finance) return financeMarker;

    if (type == MapItemType.food) return foodMarker;

    if (type == MapItemType.library) return libraryMarker;

    if (type == MapItemType.parking) return parkingMarker;

    if (type == MapItemType.store) return storeMarker;

    if (type == MapItemType.transport) return transportMarker;

    return otherMarker;
  }

  _onPinPressed(MapItem mapItem) {
    Provider.of<VisitHistory>(context, listen: false).addItem(mapItem);
    widget.showCard(mapItem);
  }

  void tryRequestLocation() {
    if (_isPlatformMobile()) {
      _requestLocationPermission();
    }
  }

  Future<void> _requestLocationPermission() async {
    await Permission.location.request();
  }

  bool _isPlatformMobile() {
    try {
      return Platform.isAndroid || Platform.isIOS;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _googleMap = new GoogleMap(
      mapType: MapType.satellite,
      rotateGesturesEnabled: true,
      tiltGesturesEnabled: false,
      compassEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      indoorViewEnabled: false,
      mapToolbarEnabled: false,
      minMaxZoomPreference: widget.mapSettings.minMaxZoomPreference,
      cameraTargetBounds: widget.mapSettings.cameraTargetBounds,
      initialCameraPosition: widget.mapSettings.initialCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        Provider.of<MapController>(context, listen: false)
            .bindWithGoogleMap(controller);
      },
      //TODO!! if _currentMarkerSet is in setState it can be in separate class accessible by provider
      markers: _currentMarkerSet,
    );
    return _googleMap;
  }

  void _updateMarkers(List<MapItem> filteredMapItems) {
    Map<MarkerId, Marker> filteredMarkers = <MarkerId, Marker>{};
    _setMarkers(filteredMarkers, filteredMapItems);
    setState(
      () {
        _currentMarkerSet = filteredMarkers.values.toSet();
      },
    );
    Provider.of<MapController>(context, listen: false)
        .zoomInto(_currentMarkerSet.first);
  }

  void _updateMarkersToDefault() {
    setState(
      () {
        //TODO!! if _currentMarkerSet is in setState it can be in separate class accessible by provider
        _currentMarkerSet = markers.values.toSet();
      },
    );
  }
}
