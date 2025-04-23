

import 'dart:convert';

TransactionTypeModel transactionTypeModelFromJson(String str) => TransactionTypeModel.fromJson(json.decode(str));

String transactionTypeModelToJson(TransactionTypeModel data) => json.encode(data.toJson());
class TransactionTypeModel {
  final int? id;
  final String? name;
  final dynamic description;

  TransactionTypeModel({
    this.id,
    this.name,
    this.description,
  });

  TransactionTypeModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      description = json['description'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'description' : description
  };
}