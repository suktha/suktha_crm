class ResponseStringModel {
  String? responseString;
  dynamic responseStatus;

  ResponseStringModel({
    this.responseString,
    this.responseStatus,  
  });

  ResponseStringModel.fromJson(Map<String, dynamic> json) {
    responseString = json['responseString'] as String?;
    responseStatus = json['responseStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['responseString'] = responseString;
    json['responseStatus'] = responseStatus;
    return json;
  }
}