class NameIdModel {
   int? id;
  final String? name;

  NameIdModel({
    this.id,
    this.name,
  });

  NameIdModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
