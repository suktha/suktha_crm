// ignore_for_file: avoid_print

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class ShareHelper {
  static Future<void> share(String content, String type) async {
    if (type == "url") {
      try {
        final response = await http.get(Uri.parse(content));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final dir = await getTemporaryDirectory();
          final name = p.basename(Uri.parse(content).path);
          final filePath = '${dir.path}/$name';
          print("File path: $name");

          final file = File(filePath);
          await file.writeAsBytes(bytes);
          await Share.shareXFiles([XFile(file.path)], text: 'Sharing file...');
        } else {
          print("Download failed with status: ${response.statusCode}");
        }
      } catch (e) {
        print("Error sharing file: $e");
      }
    } else if (type == "file") {
      await Share.shareXFiles([XFile(content)], text: 'Sharing file...');
    } else if (type == "text") {
      await Share.share(content, subject: 'Sharing text...');
    } else {
      throw ArgumentError('Invalid share type. Use "file" or "text".');
    }
  }
}
