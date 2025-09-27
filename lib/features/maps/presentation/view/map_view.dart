import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  String selectedLocation = 'No location selected';

  void handleLocationPicked(PickedData pickedData) {
    setState(() {
      selectedLocation =
          '${pickedData.latLong.latitude}, ${pickedData.latLong.longitude}';
    });

    // Optional: Show a snackbar or navigate back
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Location selected: ${pickedData.address}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FlutterLocationPicker.withConfiguration(
              userAgent: 'MyApp/1.0.0 (contact@example.com)',
              onPicked: handleLocationPicked,
              mapConfiguration: MapConfiguration(
                initZoom: 15.0,
                stepZoom: 2.0,
                mapLanguage: 'en',
                urlTemplate:
                    // 'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                mapAnimationDuration: Durations.short3,
              ),
              countryFilter: "eg",
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
