import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'package:kampus_sggw/models/map_item.dart';

class InteractiveMap extends StatefulWidget {
  final VisitedItems visitedItems;
  final TransformationController transController = TransformationController();
  final Map markers = <MarkerId, Marker>{};
  final Function _showCard;
  final Stream shouldRecenterCamera;
  List<MapItem> mapItems;

  InteractiveMap(List<MapItem> mapItems, this._showCard, this.visitedItems, this.shouldRecenterCamera) {
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
  StreamSubscription streamSubscription;

  @override
  initState() {
    super.initState();
    // Subscribe to the camera recentering event
    streamSubscription = widget.shouldRecenterCamera.listen((_) => _goToTheCampus());
  }

  @override
  dispose() {
    super.dispose();
    // Cancel the subscription when this widget is disposed
    streamSubscription.cancel();
  }

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
