import 'package:coffee_app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController _mapController = MapController();
  LocationData? currentLocation;
  final List<LatLng> _routePoints = [];
  List<Marker> _markers = [];
  final TextEditingController _searchController = TextEditingController();

  // 🔑 Replace with your own ORS key
  String orsApiKey =
      "eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6Ijc4NzI4MjEyN2I2MDQ0NTA4MjI0MzIyNmI0ZWU4MjFjIiwiaCI6Im11cm11cjY0In0=";

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Enter address...",
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (_searchController.text.isNotEmpty) {
                  _searchAddress(_searchController.text);
                }
              },
            ),
          ),
        ),
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                ),
                initialZoom: 13.0,
                onTap: (tapPosition, point) {
                  _onMapTap(point);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 4.0,
                      color: context.colors.onSecondary,
                    ),
                  ],
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getCurrentLocation();
          if (currentLocation != null) {
            _mapController.move(
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
              13.0,
            );
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }

  /// Search Address using ORS Geocoding API
  Future<void> _searchAddress(String query) async {
    final url =
        "https://api.openrouteservice.org/geocode/search?api_key=$orsApiKey&text=$query";

    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final features = response.data['features'];
        if (features.isNotEmpty) {
          final coords = features[0]['geometry']['coordinates'];
          final latLng = LatLng(coords[1], coords[0]);

          setState(() {
            _markers.add(
              Marker(
                width: 80.0,
                height: 80.0,
                point: latLng,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            );
          });

          _mapController.move(latLng, 14.0);

          // Also draw route from current location → searched address
          _getRoute(latLng);
        } else {
          debugPrint("No results found for $query");
        }
      }
    } catch (e) {
      debugPrint("Error searching address: $e");
    }
  }

  /// Get route between current location and destination
  Future<void> _getRoute(LatLng destination) async {
    if (currentLocation == null) return;
    final start = LatLng(
      currentLocation!.latitude!,
      currentLocation!.longitude!,
    );

    final response = await Dio().post(
      'https://api.openrouteservice.org/v2/directions/driving-car/geojson',
      options: Options(
        headers: {
          'Authorization': orsApiKey,
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'coordinates': [
          [start.longitude, start.latitude],
          [destination.longitude, destination.latitude],
        ],
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final coordinates =
          data['features'][0]['geometry']['coordinates'] as List;
      setState(() {
        _routePoints.clear();
        for (var coord in coordinates) {
          _routePoints.add(LatLng(coord[1], coord[0]));
        }
      });
    } else {
      throw Exception('Failed to load route');
    }
  }

  /// Handle map tap → place marker + route
  void _onMapTap(LatLng latlng) {
    setState(() {
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: latlng,
          child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
        ),
      );
    });
    _getRoute(latlng);
  }

  /// Get Current Location
  Future<void> _getCurrentLocation() async {
    var location = Location();
    try {
      var currentLocation = await location.getLocation();
      setState(() {
        this.currentLocation = currentLocation;
        if (this.currentLocation != null) {
          _routePoints.add(
            LatLng(
              this.currentLocation!.latitude!,
              this.currentLocation!.longitude!,
            ),
          );
          _markers.add(
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(
                this.currentLocation!.latitude!,
                this.currentLocation!.longitude!,
              ),
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40,
              ), // Red = user location
            ),
          );
        }
      });
    } catch (e) {
      debugPrint('Could not get the location: $e');
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        this.currentLocation = currentLocation;
      });
    });
  }
}
