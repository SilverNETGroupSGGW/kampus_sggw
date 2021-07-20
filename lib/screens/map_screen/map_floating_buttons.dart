import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/markers_event_param.dart';
import 'package:kampus_sggw/logic/search_services/markers_service.dart';
import 'package:provider/provider.dart';
import 'filtration_widgets/search_bar.dart';
import 'map_controller.dart';

class MapFloatingButtons extends StatefulWidget {
  //final Function onRecenterButtonPressed;

  // const MapFloatingButtons({
  //   Key key,
  //   @required this.onRecenterButtonPressed,
  // }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapFloatingButtons();
}

class _MapFloatingButtons extends State<MapFloatingButtons> {
  var _searchButton;
  StreamSubscription _createUnfilterButton;
  MarkersService _markersService;

  @override
  initState() {
    super.initState();
    _markersService = Provider.of<MarkersService>(context, listen: false);
    _searchButton = _filterButton();
    _createUnfilterButton = _markersService.filterEvent.listen(
        (eventParam) => _replaceFilterButtonWithUnfilterButton(eventParam));
  }

  @override
  void dispose() {
    _createUnfilterButton.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.map),
          backgroundColor: Colors.lightGreen,
          //onPressed: () => widget.onRecenterButtonPressed(),
          onPressed: () =>
              Provider.of<MapController>(context, listen: false).recenter(),
          heroTag: "btn1",
        ),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        _searchButton,
      ],
    );
  }

  FloatingActionButton _unfilterButton(String filterName) {
    return FloatingActionButton.extended(
      onPressed: () {
        _markersService.unfilterEvent.trigger();
        _replaceUnfilterButtonWithFilterButton();
      },
      label: Container(
        constraints: BoxConstraints(maxWidth: 200),
        child: Text(
          filterName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'SGGWSans',
            fontSize: 20,
          ),
        ),
      ),
      icon: const Icon(Icons.clear),
      backgroundColor: Colors.green,
    );
  }

  FloatingActionButton _filterButton() {
    return FloatingActionButton(
      child: const Icon(Icons.search),
      backgroundColor: Colors.green,
      onPressed: () => _onSearchButtonPressed(),
    );
  }

  void _onSearchButtonPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SearchBar(),
      ),
    );
  }

  void _replaceFilterButtonWithUnfilterButton(MarkersEventParam eventParam) {
    Navigator.pop(context);
    setState(
      () {
        _searchButton = _unfilterButton(eventParam.filterName);
      },
    );
  }

  void _replaceUnfilterButtonWithFilterButton() {
    setState(
      () {
        _searchButton = _filterButton();
      },
    );
  }
}
