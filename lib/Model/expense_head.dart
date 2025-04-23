// To parse this JSON data, do
//
//     final expenseHeadModel = expenseHeadModelFromJson(jsonString);

import 'dart:convert';

List<ExpenseHeadModel> expenseHeadModelFromJson(String str) => List<ExpenseHeadModel>.from(json.decode(str).map((x) => ExpenseHeadModel.fromJson(x)));

String expenseHeadModelToJson(List<ExpenseHeadModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseHeadModel {
    int? id;
    String? createdDateTime;
    String? createdBy;
    String? updatedDateTime;
    String? updatedBy;
    String? deleted;
    String name;

    ExpenseHeadModel({
        required this.id,
        required this.createdDateTime,
        required this.createdBy,
        required this.updatedDateTime,
        required this.updatedBy,
        required this.deleted,
        required this.name,
    });

    factory ExpenseHeadModel.fromJson(Map<String, dynamic> json) => ExpenseHeadModel(
        id: json["id"],
        createdDateTime: json["createdDateTime"],
        createdBy: json["createdBy"],
        updatedDateTime: json["updatedDateTime"],
        updatedBy: json["updatedBy"],
        deleted: json["deleted"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDateTime": createdDateTime,
        "createdBy": createdBy,
        "updatedDateTime": updatedDateTime,
        "updatedBy": updatedBy,
        "deleted": deleted,
        "name": name,
    };
}
