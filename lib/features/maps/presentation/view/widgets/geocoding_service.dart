import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'o_s_m_data.dart';
import 'picked_data.dart';

class GeocodingService {
  final String nominatimHost;
  final String userAgent;
  final String language;
  final Map<String, dynamic>? additionalQueryParameters;
  final String? countryFilter;

  const GeocodingService({
    required this.nominatimHost,
    required this.userAgent,
    this.language = 'en',
    this.additionalQueryParameters,
    this.countryFilter,
  });
  Map<String, String> get _httpHeaders {
    return {
      'User-Agent': userAgent,
      'Accept': 'application/json',
      'Accept-Language': language,
      'Accept-Encoding': 'gzip, deflate',
      'Connection': 'keep-alive',
      if (nominatimHost != 'nominatim.openstreetmap.org')
        'Referer': 'https://$nominatimHost/',
    };
  }

  Future<PickedData> reverseGeocode(
    LatLng coordinates, {
    int? zoomLevel,
  }) async {
    final client = http.Client();

    try {
      final queryParameters = <String, dynamic>{
        'format': 'json',
        'lat': coordinates.latitude.toString(),
        'lon': coordinates.longitude.toString(),
        'zoom': (zoomLevel ?? 18).toString(),
        'addressdetails': '1',
        'accept-language': language,
      };

      if (additionalQueryParameters != null) {
        queryParameters.addAll(additionalQueryParameters!);
      }

      final uri = Uri.https(nominatimHost, '/reverse', queryParameters);

      final response = await client
          .get(uri, headers: _httpHeaders)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw const GeocodingException(
              'Request timeout: No response from server',
            ),
          );

      if (response.statusCode == 403) {
        throw GeocodingException(
          'Access forbidden (403): Please ensure your User-Agent is properly configured. '
          'Current User-Agent: "$userAgent"',
        );
      }

      if (response.statusCode == 429) {
        throw const GeocodingException(
          'Rate limit exceeded (429): Too many requests. Please wait before making more requests.',
        );
      }

      if (response.statusCode != 200) {
        throw GeocodingException(
          'HTTP ${response.statusCode}: Failed to fetch location data',
        );
      }

      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return _parseReverseGeocodeResponse(decodedResponse, coordinates);
    } catch (e) {
      if (e is GeocodingException) rethrow;
      if (e is TimeoutException) {
        throw const GeocodingException(
          'Request timeout: Server took too long to respond',
        );
      }
      throw GeocodingException('Failed to reverse geocode: ${e.toString()}');
    } finally {
      client.close();
    }
  }

  Future<List<OSMdata>> searchLocations(String query) async {
    if (query.trim().isEmpty) return [];

    final client = http.Client();

    try {
      final queryParameters = <String, String>{
        'q': query,
        'format': 'json',
        'polygon_geojson': '1',
        'addressdetails': '1',
        'accept-language': language,
        'limit': '10', // Limit results to prevent large responses
      };

      if (countryFilter != null) {
        queryParameters['countrycodes'] = countryFilter!;
      }

      final uri = Uri.https(nominatimHost, '/search', queryParameters);

      final response = await client
          .get(uri, headers: _httpHeaders)
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () => throw const GeocodingException(
              'Search timeout: No response from server',
            ),
          );

      if (response.statusCode == 403) {
        throw GeocodingException(
          'Access forbidden (403): Please ensure your User-Agent is properly configured. '
          'Current User-Agent: "$userAgent"',
        );
      }

      if (response.statusCode == 429) {
        throw const GeocodingException(
          'Rate limit exceeded (429): Too many requests. Please wait before making more requests.',
        );
      }

      if (response.statusCode != 200) {
        throw GeocodingException(
          'HTTP ${response.statusCode}: Failed to search locations',
        );
      }

      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      return _parseSearchResponse(decodedResponse);
    } catch (e) {
      if (e is GeocodingException) rethrow;
      if (e is TimeoutException) {
        throw const GeocodingException(
          'Search timeout: Server took too long to respond',
        );
      }
      throw GeocodingException('Failed to search locations: ${e.toString()}');
    } finally {
      client.close();
    }
  }

  /// Parses reverse geocoding API response
  PickedData _parseReverseGeocodeResponse(
    dynamic response,
    LatLng coordinates,
  ) {
    const defaultDisplayName = "This location is not accessible";

    if (response is! Map<String, dynamic>) {
      return PickedData(coordinates, defaultDisplayName, {}, response);
    }

    final displayName =
        response['display_name'] as String? ?? defaultDisplayName;
    final addressData = (response['address'] as Map<String, dynamic>?) ?? {};

    if (displayName == defaultDisplayName) {
      return PickedData(const LatLng(0, 0), displayName, addressData, response);
    }

    return PickedData(coordinates, displayName, addressData, response);
  }

  /// Parses search API response
  List<OSMdata> _parseSearchResponse(List<dynamic> response) {
    return response
        .map((item) {
          try {
            return OSMdata.fromJson(item as Map<String, dynamic>);
          } catch (e) {
            return null;
          }
        })
        .where((item) => item != null && item.isValidCoordinates)
        .cast<OSMdata>()
        .toList();
  }
}

/// Custom exception for geocoding-related errors
class GeocodingException implements Exception {
  final String message;

  const GeocodingException(this.message);

  @override
  String toString() => 'GeocodingException: $message';
}
