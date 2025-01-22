import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class Geocoding {

  Future<LatLng> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      } else {
        throw Exception('No locations found for the address');
      }
    } catch (e) {
      throw Exception('Failed to get coordinates: $e');
    }
  }
}