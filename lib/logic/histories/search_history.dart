import 'dart:collection';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:kampus_sggw/logic/JSON_services/loadable_JSON.dart';
import 'package:kampus_sggw/logic/JSON_services/storable_JSON.dart';
import 'package:kampus_sggw/logic/histories/user_history.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/models/map_items.dart';
part 'search_history.g.dart';

@JsonSerializable()
class SearchHistory extends UserHistory with StorableJson, LoadableJson {
  late List<MapItem> _filtered;
  SearchHistory({int? buffer, List<int>? itemsIds})
      : super(buffer: buffer, itemsIds: itemsIds);

  UnmodifiableListView<MapItem> get filteredHistory =>
      UnmodifiableListView(_filtered);

  factory SearchHistory.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHistoryToJson(this);

  @override
  void addItem(MapItem mapItem) {
    super.addItem(mapItem);
    _save();
  }

  @override
  void deleteItem(MapItem? mapItem) {
    super.deleteItem(mapItem);
    _resetFiltered();
    _save();
  }

  @override
  void loadMapItems(MapItems mapItems) {
    super.loadMapItems(mapItems);
    _filtered = storedMapItems;
  }

  void filter(String query) {
    _filtered = _filterToMuchQuery(query: query);
    notifyListeners();
  }

  static Future<SearchHistory> loadFromJson() async {
    String jsonString = await LoadableJson.getJsonString('searchHistory');
    Map<String, dynamic> map = jsonDecode(jsonString);
    return SearchHistory.fromJson(map);
  }

  void _resetFiltered() {
    _filtered = storedMapItems;
    notifyListeners();
  }

  void _save() async {
    super.saveToJson('searchHistory');
  }

  List<MapItem> _filterToMuchQuery({String? query}) {
    if (query != null && query.isNotEmpty) {
      return _getItemsWhichNameStartsWith(query);
    } else {
      return storedMapItems;
    }
  }

  List<MapItem> _getItemsWhichNameStartsWith(String query) {
    return storedMapItems.where((item) => item.name!.startsWith(query)).toList();
  }
}
