// To parse this JSON data, do
//
//     final designationModel = designationModelFromJson(jsonString);

import 'dart:convert';

List<DesignationModel> designationModelFromJson(String str) => List<DesignationModel>.from(json.decode(str).map((x) => DesignationModel.fromJson(x)));

String designationModelToJson(List<DesignationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DesignationModel {
    int? id;
    String designationName;
    String? deleted;

    DesignationModel({
        required this.id,
        required this.designationName,
        required this.deleted,
    });

    factory DesignationModel.fromJson(Map<String, dynamic> json) => DesignationModel(
        id: json["id"],
        designationName: json["designationName"],
        deleted: json["deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "designationName": designationName,
        "deleted": deleted,
    };
}
