import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  String selectedLocation = 'No location selected';
  final List<LatLng> _routePoints = [];

  Future<void> _getRoute(PickedData destinationPoint) async {
    final start = const LatLng(30.078212838718034, 31.28506100993173);
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

        setState(() {
          _routePoints.clear();
          for (var coord in coordinates) {
            _routePoints.add(LatLng(coord[1], coord[0]));
          }
        });
      }
    } catch (e) {
      UiHelpers.showSnackBar(
        context: context,
        message: Failure.fromException(e).error,
      );
    }
  }

  void handleLocationPicked(PickedData pickedData) async {
    setState(() {
      selectedLocation =
          '${pickedData.latLong.latitude}, ${pickedData.latLong.longitude}';
    });
    await _getRoute(pickedData);
    if (!mounted) return;
    UiHelpers.showSnackBar(
      context: context,
      message: "Location selected: ${pickedData.address}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FlutterLocationPicker.withConfiguration(
              onError: (e) => UiHelpers.showSnackBar(
                context: context,
                message: Failure.fromException(e).error,
              ),
              userAgent: "coffee_app/1.0.0 (sameh.hazem504@gmail.com)",
              onPicked: handleLocationPicked,
              showCurrentLocationPointer: true,
              mapConfiguration: MapConfiguration(
                maxZoomLevel: 16,
                mapLoadingBackgroundColor: context.colors.surface,
                initZoom: 15.0,
                stepZoom: 2.0,
                mapLanguage: 'en',
                customTileProvider: NetworkTileProvider(),
                urlTemplate:
                    // 'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                mapAnimationDuration: Durations.short3,
              ),
              countryFilter: "eg",
              mapLayers: [
                if (_routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _routePoints,
                        strokeWidth: 5,
                        color: context.colors.primary,
                      ),
                    ],
                  ),
              ],
              markerConfiguration: MarkerConfiguration(
                markerIcon: Icon(
                  Ionicons.location,
                  color: context.colors.primary,
                  size: 42,
                ),
                animateMarker: true,
              ),

              //==============================
              controlsConfiguration: ControlsConfiguration(
                showZoomController: false,
                controlButtonsEnd: 0,
                locationIcon: Icons.my_location_rounded,
                showButtonShadow: false,

                buttonShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              //==============================
              searchConfiguration: SearchConfiguration(
                showSearchBar: true,
                searchBarHintText: "Search here ....",
                searchbarDebounceDuration: const Duration(milliseconds: 100),
                maxSearchResults: 8,
                searchbarBorderRadius: BorderRadius.circular(12),
                searchBarBackgroundColor: context.colors.secondary,
                searchBarTextColor: context.colors.onSecondary,
                searchBarHintColor: context.colors.onSecondary,
                searchbarInputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: context.colors.onSecondary,
                    width: 1,
                  ),
                ),
                searchbarInputFocusBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: context.colors.onSecondary,
                    width: 1.5,
                  ),
                ),
                searchResultIcon: Ionicons.search_outline,
                searchResultIconColor: context.colors.onSecondary,
              ),
              selectButtonConfiguration: SelectButtonConfiguration(
                selectLocationButtonText: 'Choose This Location',
                selectLocationButtonHeight: 56,
                selectLocationButtonPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                selectedLocationButtonTextStyle: TextStyles.medium20.copyWith(
                  color: context.colors.onPrimary,
                ),
                selectLocationButtonStyle: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  foregroundColor: context.colors.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              loadingWidget: SpinKitPulse(
                size: 64,
                color: context.colors.primary,
              ),
              trackMyPosition: true,
            ),
          ),
        ],
      ),
    );
  }
}
