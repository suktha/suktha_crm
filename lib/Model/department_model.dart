// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromJson(jsonString);

import 'dart:convert';

List<DepartmentModel> departmentModelFromJson(String str) => List<DepartmentModel>.from(json.decode(str).map((x) => DepartmentModel.fromJson(x)));

String departmentModelToJson(List<DepartmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentModel {
    int? id;
    String? departmentName;
    String? deleted;

    DepartmentModel({
        required this.id,
        required this.departmentName,
        required this.deleted,
    });

    factory DepartmentModel.fromJson(Map<String, dynamic> json) => DepartmentModel(
        id: json["id"],
        departmentName: json["departmentName"],
        deleted: json["deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "departmentName": departmentName,
        "deleted": deleted,
    };
}
