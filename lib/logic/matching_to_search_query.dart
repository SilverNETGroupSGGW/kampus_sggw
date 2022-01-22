import 'package:kampus_sggw/logic/event_parameters/suggested_item.dart';
import 'package:kampus_sggw/models/map_items.dart';

abstract class MatchingToSearchQuery {
  static List<SuggestedItem> findItemsMatchingQuery(
          MapItems items, String query) =>
      _mostSimilarItems(_getSimilarityForEachItem(items, query.toLowerCase()));

  static List<SuggestedItem> _getSimilarityForEachItem(
      MapItems items, String query) {
    List<SuggestedItem> similarityList = [];
    for (var item in items.mapItems!) {
      var similarity = item.searchingSet!.search(query);
      if (similarity.length > 0) {
        if (similarity[0].item != null) {
          similarityList.add(
            SuggestedItem(
              mapItem: item,
              matchedQuery: similarity[0].item,
              similarity: similarity[0].score,
            ),
          );
        }
      }
    }
    return similarityList;
  }

  static List<SuggestedItem> _mostSimilarItems(
      List<SuggestedItem> similarityList) {
    similarityList.sort((a, b) => a.similarity.compareTo(b.similarity));
    return similarityList.take(6).toList();
  }
}
