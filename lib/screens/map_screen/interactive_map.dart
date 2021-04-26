import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'location_pin.dart';
import 'package:kampus_sggw/models/location.dart';
import 'package:kampus_sggw/models/map.dart';

class InteractiveMap extends StatefulWidget {
  TransformationController transController = TransformationController();
  List<LocationPin> pins = [];
  Function _showCard;
  Map map = Map(
    topLeftCorner: Location(52.167685, 21.035505),
    bottomRightCorner: Location(52.155245, 21.054732),
    minScale: 0.1,
    maxScale: 0.5,
  );

  InteractiveMap(List<MapItem> mapItems, this._showCard) {
    mapItems.forEach((mapItem) {
      pins.add(LocationPin.fromMapItem(mapItem, onPinPressed, map));
    });
  }

  onPinPressed(MapItem mapItem) {
    _showCard(mapItem);
  }

  @override
  _InteractiveMapState createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  double _scale;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(52.161925644006125, 21.046382380115652),
        zoom: 16,
        maxZoom: 23,
        minZoom: 15
      ),
      layers: [
        TileLayerOptions(
          tileSize: 512, // domyślnie 256, większy kafel -> mniej requestów
          // Meta dane: https://mapy.geoportal.gov.pl/wss/service/PZGIK/ORTO/WMS/StandardResolution?service=WMS&request=GetCapabilities
          wmsOptions: WMSTileLayerOptions(
            baseUrl: "https://mapy.geoportal.gov.pl/wss/service/PZGIK/ORTO/WMS/StandardResolution?",
            layers: ["Raster"],
            // Reszta jest opcjonalna ale niech będą
            format: "image/jpeg",
            transparent: false,
            version: "1.3.0", // wersja usługi WMS
          ),
          maxNativeZoom: 23,
          minNativeZoom: 15,
          maxZoom: 23,
          minZoom: 15
        ),
        // A to OSM dla odmiany
        // TileLayerOptions(
        //     urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        //     subdomains: ['a', 'b', 'c']
        // ),
      ],
    );
  }

  void _onScaleUpdate() {
    setState(() {
      _scale = _mapScale();
    });

    _updatePins();
  }

  double _mapScale() => widget.transController.value.getMaxScaleOnAxis();

  void _updatePins() {
    for (int i = 0; i < widget.pins.length; i++) {
      widget.pins[i] =
          LocationPin.withNewScale(widget.pins[i], _scale, widget.map);
    }
  }
}
