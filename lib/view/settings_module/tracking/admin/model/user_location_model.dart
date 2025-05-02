// user_location.dart

class UserLocation {
   String id;
   String name;
   double latitude;
   double longitude;
   String imageUrl;

  UserLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
  });

  // Optional: Factory method to create a UserLocation from a JSON object
  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      imageUrl: json['imageUrl'] as String,
    );
  }

  // Optional: Method to convert a UserLocation to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
    };
  }
}
