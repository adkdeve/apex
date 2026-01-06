import 'package:latlong2/latlong.dart';

class SavedPlace {
  final String name;
  final String address;
  final LatLng location;

  SavedPlace({required this.name, this.address = "", required this.location});
}
