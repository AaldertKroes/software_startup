import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:software_startup/controllers/packagescontroller.dart';
import 'package:software_startup/classes/Package.dart';
import 'package:software_startup/services/geocoding.dart';

class PackagesMapView extends StatelessWidget {
  final PackagesController packagesController;
  final Geocoding geo = Geocoding();

  const PackagesMapView({Key? key, required this.packagesController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakketten op kaart'),
      ),
      body: FutureBuilder<List<Package>>(
        future: _getPackagesWithCoordinates(),
        builder: (BuildContext context, AsyncSnapshot<List<Package>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Fout bij ophalen van pakketten: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Geen pakketten beschikbaar.'));
          } else {
            List<Marker> markers = snapshot.data!.map((package) {
              return Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(package.latitude, package.longitude),
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 48,
                ),
              );
            }).toList();

            return Column(
              children: [
                Container(
                  height: 300,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(52.370216, 4.895168),
                      zoom: 10.0,
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
            );
          }
        },
      ),
    );
  }

  Future<List<Package>> _getPackagesWithCoordinates() async {
    List packages = await packagesController.getAddress();
    for (var package in packages) {
      package['latitude'] = await
      package['longitude'] = await Geocoding.getLng(package['destinationAddress']);
    }
    return packages;
  }
}