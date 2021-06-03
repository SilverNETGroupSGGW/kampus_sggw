import 'dart:io';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

enum Status { Updated, NotUpdated, Error }

Future<Status> checkUpdates() async {
  try {
    final directory = (await getApplicationDocumentsDirectory()).path;

    Map<String, dynamic> metadata = jsonDecode(
        await rootBundle.loadString('assets/metadata.json', cache: false));
    String token = metadata["map_items_token"];

    var response = await http.get(Uri.parse(
        'https://us-central1-kampus-sggw-2021.cloudfunctions.net/mapItems?token=' +
            token));

    if (response.statusCode != 200) {
      return Status.Error;
    }

    Map<String, dynamic> updateStatus = jsonDecode(response.body);

    if (updateStatus['error']) {
      developer.log('Error: ' + updateStatus['message']);

      return Status.Error;
    }

    developer.log('Update: ' + updateStatus['message']);

    metadata["map_items_token"] = updateStatus['token'];
    String newMapItems = updateStatus['data'];

    if (newMapItems != null && newMapItems.length != 0) {
      await File("$directory/flutter_assets/assets/metadata.json").writeAsString(jsonEncode(metadata));
      await File("$directory/flutter_assets/assets/json/map_items.json").writeAsString(newMapItems);

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
