import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  late Completer<GoogleMapController> _controller;

  MapController() {
    _controller = Completer();
  }

  void bindWithGoogleMap(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void recenter() {
    CameraPosition central = CameraPosition(
      target: LatLng(52.162012883882326, 21.046311475278525),
      tilt: 0,
      zoom: 16,
    );
    _changeCameraPosition(central);
  }

  void zoomInto(Marker marker) => _changeCameraPosition(
        CameraPosition(
          target: LatLng(marker.position.latitude, marker.position.longitude),
          tilt: 0,
          zoom: 16.5,
        ),
      );

  Future<void> _changeCameraPosition(CameraPosition newPosition) async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(newPosition),
    );
  }
}
