import 'package:flutter/material.dart';
import 'package:kampus_sggw/screens/map_screen/photo_card.dart';

class FloorTile extends StatefulWidget {
  final Image floorPlan;
  final String floorNum;

  FloorTile(this.floorPlan, this.floorNum);

  @override
  _FloorTile createState() => _FloorTile();
}

class _FloorTile extends State<FloorTile> {
  static Image _selectedFloorPlan;
  static String _selectedFloorNum;

  void _showFloorCard(Image floorPlan, String floorNum) {
    _selectedFloorPlan = floorPlan;
    _selectedFloorNum = floorNum;
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => PhotoCard(
        image: _selectedFloorPlan,
        heading: _selectedFloorNum,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.info_outline),
      title: Text(widget.floorNum),
      onTap: () => _showFloorCard(widget.floorPlan, widget.floorNum),
    );
  }
}