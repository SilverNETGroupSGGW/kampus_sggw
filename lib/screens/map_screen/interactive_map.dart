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
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) =>
                  Container(
                    child: FlutterLogo(),
                  ),
            ),
          ],
        ),
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
