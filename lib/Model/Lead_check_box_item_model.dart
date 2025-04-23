class LeadCheckboxItemModel {
  final int? id;
  final String? name;

  LeadCheckboxItemModel({
    this.id,
    this.name,
  });

  LeadCheckboxItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
