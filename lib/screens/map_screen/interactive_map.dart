import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'package:kampus_sggw/models/map_item.dart';

class InteractiveMap extends StatefulWidget {
  VisitedItems visitedItems;
  TransformationController transController = TransformationController();
  List<MapItem> mapItems;
  Map markers = <MarkerId, Marker>{};
  Function _showCard;

  InteractiveMap(List<MapItem> mapItems, this._showCard, this.visitedItems) {
    mapItems.forEach((mapItem) {
      _addMarkerFromMapItem(mapItem);
    });
  }

  void _addMarkerFromMapItem(MapItem mapItem) {
    final MarkerId markerId = MarkerId(mapItem.name);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        mapItem.geoLocation.lat,
        mapItem.geoLocation.lon,
      ),
      onTap: () {
        onPinPressed(mapItem);
      },
    );

    markers[markerId] = marker;
  }

  onPinPressed(MapItem mapItem) {
    visitedItems.addItem(mapItem.id);
    visitedItems.save();
    _showCard(mapItem);
  }

  @override
  _InteractiveMapState createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {

  Completer<GoogleMapController> _controller = Completer();
  Map markers = <MarkerId, Marker>{};

  static final CameraPosition _campusLocation = CameraPosition(
    target: LatLng(52.162012883882326, 21.046311475278525),
    tilt: 0,
    zoom: 16,
  );

  @override
  Widget build(BuildContext context) {
    return new GoogleMap(
      mapType: MapType.satellite,
      rotateGesturesEnabled: true,
      tiltGesturesEnabled: false,
      compassEnabled: true,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      minMaxZoomPreference: MinMaxZoomPreference(15, 19),
      initialCameraPosition: _campusLocation,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: Set<Marker>.of(widget.markers.values),
    );
  }

  Future<void> _goToTheCampus() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_campusLocation));
  }
}
