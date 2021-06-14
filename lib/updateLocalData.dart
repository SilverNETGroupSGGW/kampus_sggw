import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

enum Status { Updated, NotUpdated, Error }

Future<Status> checkUpdates() async {
  final tokenKey = 'map_items_token';
  final tokenVersionKey = 'map_items_token_version';
  final itemsContentKey = 'map_items_content';

  final storage = GetStorage();

  try {
    Map<String, dynamic> metadata = jsonDecode(
        await rootBundle.loadString('assets/metadata.json', cache: false));

    int assetTokenVersion = metadata[tokenVersionKey];
    int cacheTokenVersion = storage.read<int>(tokenVersionKey) ?? 0;

    // Aby nie ładować pliku jeżeli była aktualizacja aplikacji i mamy wystarczającą wersję na pokładzie
    if (assetTokenVersion > cacheTokenVersion || !storage.hasData(itemsContentKey) || !storage.hasData(tokenKey)) {
      storage.write(tokenVersionKey, assetTokenVersion);
      storage.write(tokenKey, metadata[tokenKey]);
      storage.write(itemsContentKey, await rootBundle.loadString('assets/json/map_items.json', cache: false));
    }

    String token = storage.read(tokenKey);

    Stopwatch stopwatch = new Stopwatch()..start();

    var response = await http.get(Uri.parse(
        'https://us-central1-kampus-sggw-2021.cloudfunctions.net/mapItems?token=' +
            token));

    developer.log('Info: czas pobierania aktualizacji z firebase: ' + stopwatch.elapsedMilliseconds.toString() + ' ms');

    if (response.statusCode != 200) {
      return Status.Error;
    }

    Map<String, dynamic> updateStatus = jsonDecode(response.body);

    if (updateStatus['error']) {
      developer.log('Error: ' + updateStatus['message']);

      return Status.Error;
    }

    developer.log('Update: ' + updateStatus['message']);

    metadata[tokenKey] = updateStatus['token'];
    String newMapItems = updateStatus['data'];

    if (newMapItems != null && newMapItems.length != 0) {
      storage.write(tokenKey, updateStatus['token']);
      storage.write(itemsContentKey, newMapItems);

      developer.log('Update: Zakończony');

      return Status.Updated;
    }

    return Status.NotUpdated;
  }
  catch(e) {
    developer.log('Error: ' + e.toString());

    return Status.Error;
  }
}
