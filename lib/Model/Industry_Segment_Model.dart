class IndustrySegmentModel {
  final int? id;
  final String? name;
  final String? deleted;

  IndustrySegmentModel({
    this.id,
    this.name,
    this.deleted,
  });

  IndustrySegmentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        deleted = json['deleted'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'deleted': deleted};
}
