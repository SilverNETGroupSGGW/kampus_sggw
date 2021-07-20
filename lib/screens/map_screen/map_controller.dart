import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  Completer<GoogleMapController> _controller;
  CameraPosition _centralCameraPosition;

  MapController() {
    _controller = Completer();
    _centralCameraPosition = CameraPosition(
      target: LatLng(52.162012883882326, 21.046311475278525),
      tilt: 0,
      zoom: 16,
    );
  }

  void bindWithGoogleMap(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> recenter() async {
    //final GoogleMapController controller = await _controller.future;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_centralCameraPosition),
    );
  }

  Future<void> zoomInto(Marker marker) async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(marker.position.latitude, marker.position.longitude),
          //tilt: 0,
          zoom: 16.5,
        ),
      ),
    );
  }
}
