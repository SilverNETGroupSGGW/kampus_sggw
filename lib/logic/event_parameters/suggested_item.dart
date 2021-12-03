import 'package:kampus_sggw/models/map_item.dart';

class SuggestedItem {
  MapItem? mapItem;
  String? matchedQuery;
  double? similarity;
  SuggestedItem({
    this.mapItem,
    this.matchedQuery,
    this.similarity,
  });
}
