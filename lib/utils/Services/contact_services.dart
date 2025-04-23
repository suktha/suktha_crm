import 'package:flutter/services.dart';

class ContactService {
  static const MethodChannel _channel = MethodChannel('contacts_channel');

  static Future<List<Map<String, String>>> getContacts() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod('getContacts');

      // Convert to list of maps
      List<Map<String, String>> contacts = result.map((e) => Map<String, String>.from(e)).toList();

      // Remove duplicates based on name
      final Map<String, Map<String, String>> uniqueContactsMap = {};
      for (var contact in contacts) {
        final name = contact['name']?.trim().toLowerCase() ?? ''; // normalize name
        if (name.isNotEmpty) {
          uniqueContactsMap[name] = contact;
        }
      }
      List<Map<String, String>> uniqueContacts = uniqueContactsMap.values.toList();

      // Sort alphabetically by name
      uniqueContacts.sort((a, b) {
        final nameA = a['name']?.toLowerCase() ?? '';
        final nameB = b['name']?.toLowerCase() ?? '';
        return nameA.compareTo(nameB);
      });

      return uniqueContacts;
    } on PlatformException catch (e) {
      print("Failed to get contacts: ${e.message}");
      return [];
    }
  }
}
