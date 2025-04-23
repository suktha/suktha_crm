// To parse this JSON data, do
//
//     final customerClassificationModel = customerClassificationModelFromJson(jsonString);

import 'dart:convert';

List<CustomerClassificationModel> customerClassificationModelFromJson(String str) => List<CustomerClassificationModel>.from(json.decode(str).map((x) => CustomerClassificationModel.fromJson(x)));

String customerClassificationModelToJson(List<CustomerClassificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerClassificationModel {
  dynamic id;
  String name;
  String deleted;

  CustomerClassificationModel({
    required this.id,
    required this.name,
    required this.deleted,
  });

  factory CustomerClassificationModel.fromJson(Map<String, dynamic> json) => CustomerClassificationModel(
        id: json["id"],
        name: json["name"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deleted": deleted,
      };
}
