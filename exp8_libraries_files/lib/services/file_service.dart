import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/myfile.txt');
  }

  Future<void> writeData(String data) async {
    final file = await _localFile;
    await file.writeAsString(data);
  }

  Future<void> appendData(String data) async {
    final file = await _localFile;
    await file.writeAsString(data + '\n', mode: FileMode.append);
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return 'No file found.';
      }
      return await file.readAsString();
    } catch (e) {
      return 'Error reading file: $e';
    }
  }

  Future<void> deleteData() async {
    final file = await _localFile;
    if (await file.exists()) {
      await file.delete();
    }
  }

  // JSON operations
  Future<File> get _jsonFile async {
    final path = await _localPath;
    return File('$path/notes.json');
  }

  Future<void> writeJson(String jsonString) async {
    final file = await _jsonFile;
    await file.writeAsString(jsonString);
  }

  Future<String> readJson() async {
    try {
      final file = await _jsonFile;
      if (!await file.exists()) return '[]';
      return await file.readAsString();
    } catch (e) {
      return '[]';
    }
  }
}
