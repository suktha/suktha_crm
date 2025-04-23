class MovingMaterialsModel {
  final int? materialId;
  final String? materialName;
  final int? countOfMaterials;

  MovingMaterialsModel({
    this.materialId,
    this.materialName,
    this.countOfMaterials,
  });

  MovingMaterialsModel.fromJson(Map<String, dynamic> json)
      : materialId = json['materialId'] as int?,
        materialName = json['materialName'] as String?,
        countOfMaterials = json['countOfMaterials'] as int?;

  Map<String, dynamic> toJson() => {'materialId': materialId, 'materialName': materialName, 'countOfMaterials': countOfMaterials};
}
