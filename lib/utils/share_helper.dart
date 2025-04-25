import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ShareHelper {
  /// Shares content based on input type ("file" or "text")
  static Future<void> share(String content, String type) async {
    if (type == "file") {
      try {
        final response = await http.get(Uri.parse(content));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final dir = await getTemporaryDirectory();
          final filePath = '${dir.path}/shared_file.pdf';

          final file = File(filePath);
          await file.writeAsBytes(bytes);
          await Share.shareXFiles([XFile(file.path)], text: 'Sharing file...');

          // Share the downloaded file
          // await Share.shareXFiles([XFile(file.path)], text: 'Sharing file...');
        } else {
          print("Download failed with status: ${response.statusCode}");
        }
      } catch (e) {
        print("Error sharing file: $e");
      }
    } else if (type == "text") {
      await Share.share(content, subject: 'Sharing text...');
    } else {
      throw ArgumentError('Invalid share type. Use "file" or "text".');
    }
  }
}
