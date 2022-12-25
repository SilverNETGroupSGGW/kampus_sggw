import 'package:kampus_sggw/models/map_item.dart';

class SuggestedItem {
  MapItem mapItem;
  String matchedQuery;
  double similarity;
  SuggestedItem({
    required this.mapItem,
    required this.matchedQuery,
    required this.similarity,
  });
}
