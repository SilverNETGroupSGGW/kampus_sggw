import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'location_pin.dart';
import 'map_props.dart' as map_props;

class InteractiveMap extends StatefulWidget {
  TransformationController transController = TransformationController();
  List<LocationPin> pins = [];
  Function _showCard;

  InteractiveMap(List<MapItem> mapItems, this._showCard) {
    mapItems.forEach((mapItem) {
      pins.add(LocationPin.fromMapItem(mapItem, onPinPressed));
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
    return InteractiveViewer(
      constrained: false,
      minScale: map_props.minScale,
      maxScale: map_props.maxScale,
      child: Stack(
        children: [
          Image(
            image: AssetImage("assets/images/map/map_z2.jpg"),
          ),
          Positioned.fill(
            child: Stack(
              children: widget.pins,
            ),
          ),
        ],
      ),
      onInteractionUpdate: (ScaleUpdateDetails details) {
        _onScaleUpdate();
      },
      transformationController: widget.transController,
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
      widget.pins[i] = LocationPin.withNewScale(widget.pins[i], _scale);
    }
  }
}
