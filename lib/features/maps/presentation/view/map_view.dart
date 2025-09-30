import 'dart:async';
import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/services/app_locale.dart';
import '../../../checkout/data/repo/address/address_repo_impl.dart';
import '../../../checkout/data/service/address_service.dart';
import 'widgets/geocoding_service.dart';
import 'widgets/location_service.dart';
import 'widgets/o_s_m_data.dart';
import 'widgets/picked_data.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  final List<LatLng> _routePoints = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<OSMdata> _searchOptions = <OSMdata>[];
  LatLng _currentPosition = const LatLng(30.0443879, 31.2357257);
  bool _isLoading = false;
  Timer? _debounceTimer;

  late final GeocodingService _geocodingService;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _initializeServices() {
    _geocodingService = GeocodingService(
      nominatimHost: 'nominatim.openstreetmap.org',
      userAgent: "coffee_app/1.0.0 (sameh.hazem504@gmail.com)",
      language: AppLocale.current.languageCode,
      countryFilter: "eg",
    );
  }

  Future<void> _getRoute(PickedData destinationPoint) async {
    const start = LatLng(30.078212838718034, 31.28506100993173);
    try {
      final response = await Dio().post(
        'https://api.openrouteservice.org/v2/directions/driving-car/geojson',
        options: Options(
          headers: {
            'Authorization':
                "eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6Ijc4NzI4MjEyN2I2MDQ0NTA4MjI0MzIyNmI0ZWU4MjFjIiwiaCI6Im11cm11cjY0In0=",
            'Content-Type': 'application/json',
            "User-Agent": "coffee_app/1.0.0 (sameh.hazem504@gmail.com)",
          },
        ),
        data: {
          'coordinates': [
            [start.longitude, start.latitude],
            [
              destinationPoint.latLong.longitude,
              destinationPoint.latLong.latitude,
            ],
          ],
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        final coordinates =
            data['features'][0]['geometry']['coordinates'] as List;

        final newRoutePoints = <LatLng>[];
        for (var coord in coordinates) {
          newRoutePoints.add(LatLng(coord[1], coord[0]));
        }

        setState(() {
          _routePoints.clear();
          _routePoints.addAll(newRoutePoints);
        });

        if (_routePoints.isNotEmpty) {
          final LatLngBounds bounds = LatLngBounds.fromPoints(_routePoints);
          _mapController.fitCamera(
            CameraFit.bounds(
              bounds: bounds,
              padding: const EdgeInsets.all(78.0),
              maxZoom: 15.0,
            ),
          );
        }
      }
    } catch (e) {
      UiHelpers.showSnackBar(
        context: context,
        message: Failure.fromException(e).error,
      );
    }
  }

  void handleLocationPicked(PickedData pickedData) async {
    await _getRoute(pickedData);
    if (!mounted) return;
    UiHelpers.showSnackBar(
      context: context,
      message: "Location selected: ${pickedData.address}",
    );
  }

  void _handleSearchInput(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 200), () async {
      if (value.trim().isEmpty) {
        setState(() {
          _searchOptions.clear();
        });
        return;
      }

      try {
        final results = await _geocodingService.searchLocations(value);
        setState(() {
          _searchOptions = results;
        });
      } catch (e) {
        UiHelpers.showSnackBar(
          context: context,
          message: Failure.fromException(e).error,
        );
      }
    });
  }

  void _handleSearchResultTap(OSMdata selectedLocation) {
    final center = LatLng(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );
    _mapController.move(center, 18.0);

    _searchController.text = selectedLocation.displayName;
    _focusNode.unfocus();
    setState(() {
      _searchOptions.clear();
      _currentPosition = LatLng(
        selectedLocation.latitude,
        selectedLocation.longitude,
      );
    });
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.colors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: "Search here ....",
                hintStyle: TextStyle(color: context.colors.onSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.colors.onSecondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: context.colors.onSecondary,
                    width: 1.5,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchOptions.clear();
                    });
                  },
                  icon: Icon(Icons.clear, color: context.colors.onSecondary),
                ),
              ),
              style: TextStyle(color: context.colors.onSecondary),
              onChanged: _handleSearchInput,
            ),
            if (_searchOptions.isNotEmpty) _buildSearchResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _searchOptions.length > 8 ? 8 : _searchOptions.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            Ionicons.search_outline,
            color: context.colors.onSecondary,
          ),
          title: Text(
            _searchOptions[index].displayName,
            style: TextStyle(color: context.colors.onSecondary),
          ),
          onTap: () => _handleSearchResultTap(_searchOptions[index]),
        );
      },
    );
  }

  Widget _buildCurrentLocationButton() {
    return Positioned(
      bottom: 16 + 24 + 62,
      right: 16,
      child: CustomIconButton(
        backgroundColor: context.colors.secondary,
        onPressed: () async {
          try {
            final position = await LocationService.getCurrentPosition();
            _mapController.move(position, 18);
            setState(() {
              _currentPosition = position;
            });
          } catch (e) {
            UiHelpers.showSnackBar(
              context: context,
              message: Failure.fromException(e).error,
            );
          }
        },
        child: Icon(Ionicons.locate_outline, color: context.colors.onSecondary),
      ),
    );
  }

  Widget _buildSelectButton() {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: CustomElevatedButton(
        isLoading: _isLoading,
        onPressed: () async {
          setState(() => _isLoading = true);
          try {
            final center = LatLng(
              _mapController.camera.center.latitude,
              _mapController.camera.center.longitude,
            );
            final pickedData = await _geocodingService.reverseGeocode(center);
            handleLocationPicked(pickedData);
            print(pickedData.fullResponse);
          } catch (e) {
            UiHelpers.showSnackBar(
              context: context,
              message: Failure.fromException(e).error,
            );
          } finally {
            setState(() => _isLoading = false);
          }
        },
        child: const Text('Choose This Location', style: TextStyles.medium20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 17.0,
              maxZoom: 18.4,
              minZoom: 2.0,
              backgroundColor: context.colors.surface,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                userAgentPackageName:
                    "coffee_app/1.0.0 (sameh.hazem504@gmail.com)",
                tileProvider: NetworkTileProvider(),
              ),
              CurrentLocationLayer(
                style: LocationMarkerStyle(
                  markerDirection: MarkerDirection.heading,
                  headingSectorRadius: 120,
                  markerSize: const Size(18, 18),
                  marker: CircleAvatar(
                    backgroundColor: ColorPalette.platinum,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: context.colors.primary,
                    ),
                  ),
                  accuracyCircleColor: context.colors.primary.withValues(
                    alpha: 0.2,
                  ),
                  headingSectorColor: context.colors.primary,
                  showHeadingSector: true,
                  showAccuracyCircle: true,
                ),
              ),
              if (_routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 4,
                      color: Color.lerp(
                        ColorPalette.platinum,
                        ColorPalette.orangeCrayola,
                        0.7,
                      )!,
                    ),
                  ],
                ),
            ],
          ),

          Positioned.fill(
            bottom: 50.0,
            child: IgnorePointer(
              child: Center(
                child: Icon(
                  Ionicons.location,
                  color: context.colors.primary,
                  size: 42,
                ),
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: SpinKitPulse(size: 64, color: context.colors.primary),
            ),
          SafeArea(
            child: Stack(
              children: [
                _buildSearchBar(),
                _buildCurrentLocationButton(),
                _buildSelectButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
