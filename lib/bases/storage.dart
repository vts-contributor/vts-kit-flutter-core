import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
export 'storage.dart' hide Storage;

abstract class Storage {
  static Future<String> get internalStoragePath async {
    final internalStorage = await getApplicationDocumentsDirectory();
    return internalStorage.path;
  }

  static Future<bool> extractZipFile(String archiveFile,
      {String? filePath}) async {
    try {
      String path = filePath ?? await internalStoragePath;
      List<int> bytes = File('$path/$archiveFile').readAsBytesSync();
      Archive archive = ZipDecoder().decodeBytes(bytes);
      for (final file in archive) {
        final filename = file.name;
        if (file.isFile) {
          final data = file.content as List<int>;
          File('$path/$filename')
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        } else {
          Directory('$path/$filename')..create(recursive: true);
        }
      }
    } catch (error) {
      print('ERROR extractZipFiles: $archiveFile, error: $error');
      return false;
    }
    return true;
  }

  static Future<Map<String, dynamic>?> readJsonFile(String jsonFile,
      {String? filePath}) async {
    Map<String, dynamic>? jsonMap;
    String path = filePath ?? await internalStoragePath;
    final file = File('$path/$jsonFile');
    if (await file.exists()) {
      String jsonString = await file.readAsString();
      jsonMap = jsonDecode(jsonString);
    }
    return jsonMap;
  }
}
