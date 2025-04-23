
class GraphModel {
  int? monthNumber;
  String? month;
  String? transactionName;
  double? transactionAmount;
  int? transactionCount;
  double? dueAmount;
  int? financialYear;

  GraphModel({
    this.monthNumber,
    this.month,
    this.transactionName,
    this.transactionAmount,
    this.transactionCount,
    this.dueAmount,
    this.financialYear,
  });

//  factory GraphModel.fromJson(Map<String, dynamic> json) {
//     monthNumber = json['monthNumber'] as int?;
//     month = json['month'] as String?;
//     transactionName = json['transactionName'] as String?;
//     transactionAmount = json['transactionAmount'] as int?;
//     transactionCount = json['transactionCount'] as int?;
//     dueAmount = json['dueAmount'] as int?;
//     financialYear = json['financialYear'] as int?;
//   }

factory GraphModel.fromJson(Map<String,dynamic> json) => GraphModel(
 monthNumber : json['monthNumber'],
    month : json['month'] ,
    transactionName : json['transactionName'] ,
    transactionAmount : json['transactionAmount'] ,
    transactionCount : json['transactionCount'] ,
    dueAmount : json['dueAmount'] ,
    financialYear : json['financialYear'] 

);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['monthNumber'] = monthNumber;
    json['month'] = month;
    json['transactionName'] = transactionName;
    json['transactionAmount'] = transactionAmount;
    json['transactionCount'] = transactionCount;
    json['dueAmount'] = dueAmount;
    json['financialYear'] = financialYear;
    return json;
  }
}