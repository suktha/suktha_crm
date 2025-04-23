class DropdownUserModel {
  final int? id;
  final String? name;

  DropdownUserModel({
    this.id,
    this.name,
  });

  DropdownUserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
