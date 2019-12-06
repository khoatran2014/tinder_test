import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DataHelper {
  DataHelper._();

  static final DataHelper profile = DataHelper._();

  Future<String> get _filePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _filePath;
    return File(join(path, "profiles.txt"));
  }

  Future<String> getProfiles() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (ex) {
      return '';
    }
  }

  Future<File> saveProfile(String profileList) async {
    final file = await _localFile;
    return file.writeAsString(profileList);
  }

}