import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/markers_event_param.dart';
import 'package:kampus_sggw/logic/search_services/stream_service.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/screens/map_screen/map_markers.dart';
import 'package:kampus_sggw/screens/map_screen/search_button.dart';

class MarkersService extends ChangeNotifier {
  //StreamService _filter;
  //StreamService _unfilter;
  MapMarkers _mapMarkers;
  SearchButton _searchButton;

  //StreamService get filterEvent => _filter;
  //StreamService get unfilterEvent => _unfilter;

  MarkersService({MapMarkers mapMarkers}) {
    _mapMarkers = mapMarkers;
    //_filter = StreamService();
    //_unfilter = StreamService();
  }

  set searchButton(SearchButton value) {
    _searchButton = value;
  }

  void filter(String filterName, List<MapItem> filteredItems) {
    //_filter.trigger(
    //param: MarkersEventParam(filterName, filteredItems),
    //);
    _mapMarkers.updateMarkers(filteredItems);
    _searchButton.showUnfilterButton(filterName);
  }

  void showSearchedItem(MapItem item) {
    //_filter.trigger(
    //param: MarkersEventParam(item.name, [item]),
    //);
    filter(item.name, [item]);
  }

  //@override
  //void dispose() {
  //_filter.dispose();
  //_unfilter.dispose();
  //super.dispose();
  //}
}
