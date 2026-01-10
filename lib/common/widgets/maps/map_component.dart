import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../../app/core/core.dart';

/// A versatile and reusable map component built on top of FlutterMap.
class MapComponent extends StatelessWidget {
  const MapComponent({
    Key? key,
    required this.mapController,
    required this.initialCenter,
    this.initialZoom = 14.5,
    this.tileLayerUrl,
    this.polylines = const [],
    this.markers = const [],
    this.circles = const [],
    this.onMapReady,
    this.onTap,
    this.onPositionChanged,
    this.enableRotation = false,
    this.interactionFlags,
    this.children = const [],
  }) : super(key: key);

  final MapController mapController;
  final LatLng initialCenter;
  final double initialZoom;
  final String? tileLayerUrl;
  final List<Polyline> polylines;
  final List<Marker> markers;
  final List<CircleMarker> circles;
  final VoidCallback? onMapReady;
  final void Function(TapPosition, LatLng)? onTap;
  final void Function(MapPosition, bool)? onPositionChanged;
  final bool enableRotation;
  final int? interactionFlags;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    // Automatically select tile URL based on theme brightness
    final isDarkMode = Get.isDarkMode;
    final defaultTileUrl =
        tileLayerUrl ??
        (isDarkMode
            ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png'
            : 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png');

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
        onMapReady: onMapReady,
        onTap: onTap,
        onPositionChanged: onPositionChanged,
      ),
      children: [
        TileLayer(
          urlTemplate: defaultTileUrl,
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.devitcity.apex',
        ),
        if (polylines.isNotEmpty) PolylineLayer(polylines: polylines),
        if (circles.isNotEmpty) CircleLayer(circles: circles),
        if (markers.isNotEmpty) MarkerLayer(markers: markers),
        ...children,
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
    Color? color,
    double strokeWidth = 5.0,
  }) {
    return Polyline(
      points: points,
      strokeWidth: strokeWidth,
      color: color ?? R.theme.primary,
    );
  }
}
