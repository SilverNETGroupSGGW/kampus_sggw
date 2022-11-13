import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampus_sggw/models/map_settings.dart';
import 'package:kampus_sggw/logic/controllers/map_controller.dart';
import 'package:kampus_sggw/logic/controllers/map_markers_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:provider/provider.dart';

class InteractiveMap extends StatefulWidget {
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
  @override
  _InteractiveMapState createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  @override
  void initState() {
    super.initState();
    tryRequestLocation();
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
    return GoogleMap(
      mapType: MapType.satellite,
      rotateGesturesEnabled: true,
      tiltGesturesEnabled: false,
      compassEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      indoorViewEnabled: false,
      mapToolbarEnabled: false,
      minMaxZoomPreference: widget.mapSettings.minMaxZoomPreference!,
      cameraTargetBounds: widget.mapSettings.cameraTargetBounds!,
      initialCameraPosition: widget.mapSettings.initialCameraPosition!,
      onMapCreated: (GoogleMapController controller) {
        Provider.of<MapController>(context, listen: false)
            .bindWithGoogleMap(controller);
      },
      markers: Provider.of<MapMarkersController>(context, listen: true).markers,
    );
  }
}
