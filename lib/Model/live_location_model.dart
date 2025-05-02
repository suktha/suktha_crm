class LiveLocationModel {
  final String? id;
  final DateTime? eventDateTime;
  final double longitude;
  final double latitude;
  final int? userId;
  final String? userName;
  final String? eventName;
  final String? message;
  final int? reasonId;
  final String? destinationUrl;
  final String? transId;
  final String? eventDisplayName;

  LiveLocationModel({
    required this.id,
    required this.eventDateTime,
    required this.longitude,
    required this.latitude,
    required this.userId,
    required this.userName,
    this.eventName,
    required this.message,
    this.reasonId,
    this.destinationUrl,
    this.transId,
    this.eventDisplayName,
  });

  factory LiveLocationModel.fromJson(Map<String, dynamic> json) {
    return LiveLocationModel(
      id: json['id'],
      eventDateTime: json['eventDateTime'] != null ? DateTime.tryParse(json['eventDateTime']) : null,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      userId: json['userId'],
      userName: json['userName'],
      eventName: json['eventName'],
      message: json['message'],
      reasonId: json['reasonId'],
      destinationUrl: json['destinationUrl'],
      transId: json['transId'],
      eventDisplayName: json['eventDisplayName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventDateTime': eventDateTime?.toIso8601String(),
      'longitude': longitude,
      'latitude': latitude,
      'userId': userId,
      'userName': userName,
      'eventName': eventName,
      'message': message,
      'reasonId': reasonId,
      'destinationUrl': destinationUrl,
      'transId': transId,
      'eventDisplayName': eventDisplayName,
    };
  }
}
