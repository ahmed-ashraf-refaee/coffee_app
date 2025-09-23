import 'package:dio/dio.dart';

class LocationService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://api.openrouteservice.org/v2/"),
  );

  Future<List<String>> getGovernorates(String query) async {
    final res = await _dio.get("/governorates", queryParameters: {"q": query});
    return List<String>.from(res.data.map((g) => g["name"]));
  }

  Future<List<String>> getCities(String governorate, String query) async {
    final res = await _dio.get(
      "/cities",
      queryParameters: {"governorate": governorate, "q": query},
    );
    return List<String>.from(res.data.map((c) => c["name"]));
  }

  Future<List<String>> getAddresses(String city, String query) async {
    final res = await _dio.get(
      "/addresses",
      queryParameters: {"city": city, "q": query},
    );
    return List<String>.from(res.data.map((a) => a["name"]));
  }
}
