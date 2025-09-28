import 'package:latlong2/latlong.dart';

class PickedData {
  final LatLng latLong;
  final String address;
  final Map<String, dynamic> addressData;
  final dynamic fullResponse;
  const PickedData(
    this.latLong,
    this.address,
    this.addressData,
    this.fullResponse,
  );

  String get formattedAddress {
    if (addressData.isEmpty) return address;
    final components = <String>[];
    final houseNumber = addressData['house_number'];
    final road = addressData['road'];
    if (houseNumber != null && road != null) {
      components.add('$houseNumber $road');
    } else if (road != null) {
      components.add(road);
    }
    final city =
        addressData['city'] ?? addressData['town'] ?? addressData['village'];
    if (city != null) components.add(city);
    final country = addressData['country'];
    if (country != null) components.add(country);
    return components.isNotEmpty ? components.join(', ') : address;
  }

  PickedData copyWith({
    LatLng? latLong,
    String? address,
    Map<String, dynamic>? addressData,
    dynamic fullResponse,
  }) {
    return PickedData(
      latLong ?? this.latLong,
      address ?? this.address,
      addressData ?? this.addressData,
      fullResponse ?? this.fullResponse,
    );
  }
}
