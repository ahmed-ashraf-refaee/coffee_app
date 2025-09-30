class Address {
  final int id;
  final String street;
  final String city;
  final double latitude;
  final double longitude;
  final String phoneNumber;

  Address({
    required this.id,
    required this.street,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
  });

  factory Address.fromJson(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as int,
      street: map['street'] as String,
      city: map['city'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      phoneNumber: map['phone_number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'phone_number': phoneNumber,
    };
  }
}
