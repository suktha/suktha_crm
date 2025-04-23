class GetServiceTimeSpanModel {
  final int? id;
  final String? name;
  final int? days;

  GetServiceTimeSpanModel({
    this.id,
    this.name,
    this.days,
  });

  GetServiceTimeSpanModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        days = json['days'] as int?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'days': days};
}
