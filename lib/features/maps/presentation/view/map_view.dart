import 'dart:async';
import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/title_subtitle.dart';
import 'package:coffee_app/features/authentication/presentation/view/authentication_view/widgets/build_suffix_icon_with_divider.dart';
import 'package:coffee_app/features/checkout/data/models/address_model.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/services/app_locale.dart';
import 'widgets/geocoding_service.dart';
import 'widgets/location_service.dart';
import 'widgets/o_s_m_data.dart';
import 'widgets/picked_data.dart';

class MapsView extends StatefulWidget {
  final Map<String, double>? latlong;

  const MapsView({super.key, this.latlong});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<LatLng> _routePoints = [];
  List<OSMdata> _searchOptions = [];
  LatLng _currentPosition = const LatLng(30.0443879, 31.2357257);
  LatLng? _pickedPosition;
  bool _isLoading = false;
  Timer? _debounceTimer;
  late final GeocodingService _geocodingService;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _initLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounceTimer?.cancel();
    _removeOverlay();
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

  Future<void> _initLocation() async {
    if (widget.latlong != null) {
      final LatLng saved = LatLng(
        widget.latlong!['lat']!,
        widget.latlong!['lng']!,
      );
      setState(() {
        _currentPosition = saved;
        _pickedPosition = saved;
      });
    } else {
      try {
        final position = await LocationService.getCurrentPosition();
        if (!mounted) return;
        setState(() {
          _currentPosition = position;
          _pickedPosition = position;
        });
      } catch (e) {
        UiHelpers.showSnackBar(
          context: context,
          message: Failure.fromException(e).error,
        );
      }
    }
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
        final coordinates =
            response.data['features'][0]['geometry']['coordinates'] as List;
        final newRoutePoints = coordinates
            .map((c) => LatLng(c[1], c[0]))
            .toList();
        setState(() {
          _routePoints
            ..clear()
            ..addAll(newRoutePoints);
        });
        if (_routePoints.isNotEmpty) {
          final bounds = LatLngBounds.fromPoints(_routePoints);
          _mapController.fitCamera(
            CameraFit.bounds(
              bounds: bounds,
              padding: const EdgeInsets.all(78),
              maxZoom: 15,
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

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay(BuildContext context) {
    _removeOverlay();

    // Safety check
    if (!mounted || _searchOptions.isEmpty) return;

    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 32, // Account for padding
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: const Offset(0, 16),
          child: Material(
            elevation: 0,
            color: context.colors.secondary,
            borderRadius: BorderRadius.circular(12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 280),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _searchOptions.length > 8
                    ? 8
                    : _searchOptions.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: Icon(
                      Ionicons.search_outline,
                      color: context.colors.onSecondary,
                    ),
                    title: Text(
                      _searchOptions[i].displayName,
                      style: TextStyle(color: context.colors.onSecondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      _handleSearchResultTap(_searchOptions[i]);
                      _removeOverlay();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _handleSearchInput(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 250), () async {
      if (value.trim().isEmpty) {
        _removeOverlay();
        setState(() => _searchOptions.clear());
        return;
      }
      try {
        final results = await _geocodingService.searchLocations(value);
        setState(() => _searchOptions = results);
        if (_searchOptions.isNotEmpty) _showOverlay(context);
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
    _mapController.move(center, 18);
    _searchController.text = selectedLocation.displayName;
    _focusNode.unfocus();
    setState(() {
      _pickedPosition = center;
      _currentPosition = center;
    });
  }

  Future<void> _confirmLocation() async {
    setState(() => _isLoading = true);
    try {
      final center = _pickedPosition ?? _currentPosition;
      final pickedData = await _geocodingService.reverseGeocode(center);
      if (!mounted) return;
      final address = AddressModel(
        id: pickedData.fullResponse['place_id'],
        address: pickedData.fullResponse['display_name'],
        city: pickedData.fullResponse['address']['city'],
        latitude: pickedData.latLong.latitude,
        longitude: pickedData.latLong.longitude,
        state: pickedData.fullResponse['address']['state'],
      );
      GoRouter.of(context).pop(address);
    } catch (e) {
      UiHelpers.showSnackBar(
        context: context,
        message: Failure.fromException(e).error,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildSearchInput() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: _searchController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: S.current.searchYourLocation,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          suffixIcon: buildSuffixIconWithDivider(
            context,
            CustomIconButton(
              onPressed: () {
                _searchController.clear();
                _removeOverlay();
                setState(() => _searchOptions.clear());
              },
              child: Icon(Icons.clear, color: context.colors.onSecondary),
            ),
          ),
        ),
        onChanged: _handleSearchInput,
      ),
    );
  }

  Widget _buildBottomButtons() {
    return CustomElevatedButton(
      height: 56,
      isLoading: _isLoading,
      onPressed: _confirmLocation,
      child: Text(S.current.confirmLocation, style: TextStyles.medium20),
    );
  }

  @override
  Widget build(BuildContext context) {
    final map = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight * 0.7),
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _currentPosition,
                    initialZoom: 17,
                    maxZoom: 18.4,
                    minZoom: 2,
                    onTap: (tapPosition, latlng) =>
                        setState(() => _pickedPosition = latlng),
                    onMapReady: () {
                      _mapController.move(
                        _pickedPosition ?? _currentPosition,
                        17,
                      );
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                      userAgentPackageName: "coffee_app/1.0.0",
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
                            backgroundColor: context.colors.surface,
                          ),
                        ),
                        accuracyCircleColor: context.colors.primary.withValues(
                          alpha: 0.2,
                        ),
                        headingSectorColor: context.colors.secondary,
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
                    if (_pickedPosition != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _pickedPosition!,
                            width: 42,
                            height: 42,
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Ionicons.location,
                              color: context.colors.primary,
                              size: 42,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (_isLoading)
                  Center(
                    child: SpinKitPulse(
                      size: 64,
                      color: context.colors.primary,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              CustomAppBar(
                leading: CustomIconButton(
                  padding: 8,
                  onPressed: () => GoRouter.of(context).pop(),
                  child: Icon(
                    Ionicons.chevron_back,
                    color: context.colors.onSecondary,
                  ),
                ),
                trailing: CustomIconButton(
                  padding: 8,
                  onPressed: () async {
                    try {
                      final position =
                          await LocationService.getCurrentPosition();
                      _mapController.move(position, 18);
                      setState(() {
                        _currentPosition = position;
                        _pickedPosition = position;
                      });
                    } catch (e) {
                      UiHelpers.showSnackBar(
                        context: context,
                        message: Failure.fromException(e).error,
                      );
                    }
                  },
                  child: Icon(Ionicons.locate, color: context.colors.primary),
                ),
              ),
              TitleSubtitle(
                title: S.current.selectAddressOnMap,
                subtitle: S.current.selectAddressSubtitle,
              ),
              _buildSearchInput(),
              Expanded(child: map),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
