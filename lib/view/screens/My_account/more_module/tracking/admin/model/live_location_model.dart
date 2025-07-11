class GeoLocationModel {
  final String? id;
  final String? eventDateTime;
  final double longitude;
  final double latitude;
  final int userId;
  final dynamic userName;

  GeoLocationModel({
    this.id,
    this.eventDateTime,
    required this.longitude,
    required this.latitude,
    required this.userId,
    this.userName,
  });

  GeoLocationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        eventDateTime = json['eventDateTime'] as String?,
        longitude = json['longitude'] as double,
        latitude = json['latitude'] as double,
        userId = json['userId'] as int,
        userName = json['userName'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'eventDateTime': eventDateTime, 'longitude': longitude, 'latitude': latitude, 'userId': userId, 'userName': userName};
}
