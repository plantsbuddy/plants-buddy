import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

class DownloadImageFromUrl {
  Future<String> call(String url) async {
    final response = await http.get(Uri.parse(url));
    final documentDirectory = await getApplicationSupportDirectory();
    final filePathAndName = '${documentDirectory.path}/${DateTime.now().millisecondsSinceEpoch}';

    final file2 = File(filePathAndName);
    await file2.writeAsBytes(response.bodyBytes);

    return file2.path;
  }
}
