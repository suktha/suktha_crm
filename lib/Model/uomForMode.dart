class GetServiceUomForModel {
  final int? id;
  final String? name;

  GetServiceUomForModel({
    this.id,
    this.name,
  });

  GetServiceUomForModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
