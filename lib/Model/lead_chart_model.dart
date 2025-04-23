class LeadChartModel {
  final int? id;
  final String? name;
  final int? value;

  LeadChartModel({
    this.id,
    this.name,
    this.value,
  });

  LeadChartModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        value = json['value'] as int?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'value': value};
}
