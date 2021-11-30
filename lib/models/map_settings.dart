import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSettings {
  CameraPosition? initialCameraPosition;
  CameraTargetBounds? cameraTargetBounds;
  MinMaxZoomPreference? minMaxZoomPreference;

  MapSettings({
    this.initialCameraPosition,
    this.cameraTargetBounds,
    this.minMaxZoomPreference,
  });
}
