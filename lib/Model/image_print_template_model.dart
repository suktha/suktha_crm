class ImagePrintTemplatesModel {
  final int? id;
  final String? image;
  final String? name;
  final String? jasperFileName;

  ImagePrintTemplatesModel({
    this.name,
    this.jasperFileName,
    this.id,
    this.image,
  });

  ImagePrintTemplatesModel.fromJson(
    Map<String, dynamic> json,
  )   : name = json['name'] as String?,
        jasperFileName = json['jasperFileName'] as String?,
        id = json['id'] as int?,
        image = json['image'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'image': image};
}
