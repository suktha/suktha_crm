class PaymentMethodModel {
  int? id;
  final String? name;
  final String? isCard;

  PaymentMethodModel({
    this.id,
    this.name,
    this.isCard,
  });

  PaymentMethodModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        isCard = json['isCard'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'isCard': isCard};
}
