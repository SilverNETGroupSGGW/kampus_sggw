import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/event_parameters/markers_event_param.dart';
import 'package:kampus_sggw/logic/search_services/stream_service.dart';
import 'package:kampus_sggw/models/map_item.dart';

class MarkersService extends ChangeNotifier {
  StreamService _filter;
  StreamService _unfilter;

  StreamService get filterEvent => _filter;
  StreamService get unfilterEvent => _unfilter;

  MarkersService() {
    _filter = StreamService();
    _unfilter = StreamService();
  }

  void trigger(String filterName, List<MapItem> filteredItems) =>
      _filter.trigger(
        param: MarkersEventParam(filterName, filteredItems),
      );

  @override
  void dispose() {
    _filter.dispose();
    _unfilter.dispose();
    super.dispose();
  }
}
