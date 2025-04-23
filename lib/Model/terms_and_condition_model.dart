class TermsAndConditionModel {
  int? id;
  String? name;
  String? termsAndCondition;
  dynamic paymentTerms;
  dynamic deliveryTerms;
  int? defaultTermsAndCondition;
  int? transactionTypeId;
  String? deleted;

  TermsAndConditionModel({
    this.id,
    this.name,
    this.termsAndCondition,
    this.paymentTerms,
    this.deliveryTerms,
    this.defaultTermsAndCondition,
    this.transactionTypeId,
    this.deleted,
  });

  TermsAndConditionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    termsAndCondition = json['termsAndCondition'] as String?;
    paymentTerms = json['paymentTerms'];
    deliveryTerms = json['deliveryTerms'];
    defaultTermsAndCondition = json['defaultTermsAndCondition'] as int?;
    transactionTypeId = json['transactionTypeId'] as int?;
    deleted = json['deleted'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['termsAndCondition'] = termsAndCondition;
    json['paymentTerms'] = paymentTerms;
    json['deliveryTerms'] = deliveryTerms;
    json['defaultTermsAndCondition'] = defaultTermsAndCondition;
    json['transactionTypeId'] = transactionTypeId;
    json['deleted'] = deleted;
    return json;
  }
}