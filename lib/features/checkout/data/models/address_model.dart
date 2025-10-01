class AddressModel {
  final int? id;
  final String? title;
  final String address;
  final String city;
  final double? latitude;
  final double? longitude;
  final String? phoneNumber;
  final String state;
  final String? optionalPhoneNumber;

  AddressModel({
    this.title,
    this.id,
    required this.address,
    required this.city,
    this.latitude,
    this.longitude,
    this.phoneNumber,
    required this.state,
    this.optionalPhoneNumber,
  });

  factory AddressModel.fromJson(Map<String, dynamic> map) {
    return AddressModel(
      title: map['title'] as String,
      id: map['id'] as int,
      address: map['address'] as String,
      city: map['city'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      phoneNumber: map['phone_number'] as String,
      state: map['state'] as String,
      optionalPhoneNumber: map['optional_phone_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'phone_number': phoneNumber,
      'state': state,
      'optional_phone_number': optionalPhoneNumber,
      'title': title,
    };
  }
}
