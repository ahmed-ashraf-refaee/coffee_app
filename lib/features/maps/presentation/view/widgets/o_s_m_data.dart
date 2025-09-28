class OSMdata {
  final String displayName;
  final double latitude;
  final double longitude;
  const OSMdata({
    required this.displayName,
    required this.latitude,
    required this.longitude,
  });
  bool get isValidCoordinates =>
      latitude >= -90 &&
      latitude <= 90 &&
      longitude >= -180 &&
      longitude <= 180;
  factory OSMdata.fromJson(Map<String, dynamic> json) {
    return OSMdata(
      displayName: json['display_name'] ?? '',
      latitude: double.tryParse(json['lat']?.toString() ?? '0') ?? 0.0,
      longitude: double.tryParse(json['lon']?.toString() ?? '0') ?? 0.0,
    );
  }
}
