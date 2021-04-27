import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/visited_items.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'location_pin.dart';
import 'package:kampus_sggw/models/location.dart';
import 'package:kampus_sggw/models/map.dart';

class InteractiveMap extends StatefulWidget {
  VisitedItems visitedItems;
  TransformationController transController = TransformationController();
  List<LocationPin> pins = [];
  Function _showCard;
  Map map = Map(
    topLeftCorner: Location(52.167685, 21.035505),
    bottomRightCorner: Location(52.155245, 21.054732),
    minScale: 0.1,
    maxScale: 0.5,
  );

  InteractiveMap(List<MapItem> mapItems, this._showCard, this.visitedItems) {
    mapItems.forEach((mapItem) {
      pins.add(LocationPin.fromMapItem(mapItem, onPinPressed, map));
    });
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
  double _scale;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      minScale: widget.map.minScale,
      maxScale: widget.map.maxScale,
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
      widget.pins[i] =
          LocationPin.withNewScale(widget.pins[i], _scale, widget.map);
    }
  }
}
