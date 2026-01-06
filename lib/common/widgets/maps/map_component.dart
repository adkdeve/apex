import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Reusable map component (FlutterMap setup)
/// Used in: point_to_point_view, ride_selection_view, ride_booked_view
class MapComponent extends StatelessWidget {
  const MapComponent({
    Key? key,
    required this.mapController,
    required this.initialCenter,
    this.initialZoom = 14.5,
    this.tileLayerUrl,
    this.polylines = const [],
    this.markers = const [],
    this.onMapReady,
    this.enableRotation = false,
    this.interactionFlags,
  }) : super(key: key);

  final MapController mapController;
  final LatLng initialCenter;
  final double initialZoom;
  final String? tileLayerUrl;
  final List<Polyline> polylines;
  final List<Marker> markers;
  final VoidCallback? onMapReady;
  final bool enableRotation;
  final int? interactionFlags;

  @override
  Widget build(BuildContext context) {
    final String defaultTileUrl =
        tileLayerUrl ??
        'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png';

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: initialZoom,
        interactionOptions: InteractionOptions(
          flags:
              interactionFlags ??
              (enableRotation
                  ? InteractiveFlag.all
                  : InteractiveFlag.all & ~InteractiveFlag.rotate),
        ),
        onMapReady: onMapReady != null ? () => onMapReady!() : null,
      ),
      children: [
        TileLayer(
          urlTemplate: defaultTileUrl,
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.devitcity.apex',
        ),
        if (polylines.isNotEmpty) PolylineLayer(polylines: polylines),
        if (markers.isNotEmpty) MarkerLayer(markers: markers),
      ],
    );
  }
}

/// Helper class to create common map markers
class MapMarkerHelper {
  /// Create a pickup marker (green)
  static Marker pickupMarker({
    required LatLng point,
    double size = 40,
    Color color = const Color(0xFF27AE60),
  }) {
    return Marker(
      point: point,
      width: size,
      height: size,
      child: Icon(Icons.location_on, color: color, size: size),
    );
  }

  /// Create a dropoff marker (red)
  static Marker dropoffMarker({
    required LatLng point,
    double size = 40,
    Color color = Colors.redAccent,
  }) {
    return Marker(
      point: point,
      width: size,
      height: size,
      child: Icon(Icons.location_on, color: color, size: size),
    );
  }

  /// Create a custom marker
  static Marker customMarker({
    required LatLng point,
    required Widget child,
    double width = 40,
    double height = 40,
  }) {
    return Marker(point: point, width: width, height: height, child: child);
  }
}

/// Helper class to create common polylines
class MapPolylineHelper {
  /// Create a route polyline
  static Polyline routePolyline({
    required List<LatLng> points,
    Color color = const Color(
      0xFFCFA854,
    ), // TODO: Should use R.theme.goldAccent but requires import
    double strokeWidth = 5.0,
  }) {
    return Polyline(points: points, strokeWidth: strokeWidth, color: color);
  }
}
