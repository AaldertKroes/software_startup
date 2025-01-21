import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:software_startup/mocks/packageController_map.dart';
import 'package:software_startup/classes/Package.dart';

class PackagesMapView extends StatelessWidget {
  final PackagesController packagesController = PackagesController();

  @override
  Widget build(BuildContext context) {
    // Verkrijg de lijst van pakketten
    List<Package> packages = packagesController.getPackages();

    // Maak markers voor elk pakket
    List<Marker> markers = packages.map((package) {
      return Marker(
        width: 80.0,
        height: 80.0,
        //point: LatLng(package.latitude, package.longitude),
        point: LatLng(53.123, 6.123),
        builder: (ctx) => Icon(
          Icons.location_on,
          color: Colors.red,
          size: 48,
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakketten op kaart'),
      ),
    body: Column(
      children: [
        Container(
          height: 300,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(52.370216, 4.895168), // Startpositie van de kaart
                zoom: 10.0, // Startzoomniveau
                maxZoom: 18.0,
                minZoom: 5.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: markers),
              ],
            ),
    ),
    ],
      ),
    );
  }
}
