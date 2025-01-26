import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:software_startup/controllers/packagescontroller.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';
import '../services/geocoding.dart';

class MapView extends StatefulWidget {
  final PackagesController packagesController;
  final Geocoding geocoding = Geocoding();

  MapView({Key? key, required this.packagesController}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Map<String, dynamic>? selectedPackage;
  List<dynamic> allPackages = [];
  List<dynamic> filteredPackages = [];
  final LatLng fixedCoordinate = LatLng(53, 6.27);
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPackages();
  }

  Future<void> _loadPackages() async {
    List<dynamic> packages = await _getPackagesWithCoordinates();
    setState(() {
      allPackages = packages;
      filteredPackages = packages;
    });
  }

  void _filterPackages(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredPackages = allPackages;
      });
      return;
    }

    double distance = double.tryParse(query) ?? 0;
    setState(() {
      filteredPackages = allPackages.where((package) {
        double packageDistance = _calculateDistance(
          fixedCoordinate.latitude,
          fixedCoordinate.longitude,
          package.latitude,
          package.longitude,
        );
        return packageDistance <= distance;
      }).toList();
    });
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double p = 0.017453292519943295;
    final double c = 0.5 - cos((lat1 - lat2) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(c));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakketten op kaart'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Zoek op afstand (km)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: _filterPackages,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<DeliveryPackageModel>>(
              future: _getPackagesWithCoordinates(),
              builder: (BuildContext context, AsyncSnapshot<List<DeliveryPackageModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Fout bij ophalen van pakketten: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Geen pakketten beschikbaar.'));
                } else {
                  List<Marker> markers = filteredPackages.map((package) {
                    return Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(package.latitude, package.longitude),
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPackage = package;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 48,
                            ),
                            Text('ID: ${package.id}'),
                          ],
                        ),
                      ),
                    );
                  }).toList();

                  List<Polyline> polylines = filteredPackages.map((package) {
                    return Polyline(
                      points: [
                        LatLng(package.latitude, package.longitude),
                        LatLng(package.destinationLatitude, package.destinationLongitude),
                      ],
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    );
                  }).toList();

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 300,
                          child: FlutterMap(
                            options: MapOptions(
                              center: LatLng(53.206, 6.587),
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
                              PolylineLayer(polylines: polylines),
                            ],
                          ),
                        ),
                        if (selectedPackage != null)
                          Card(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pakket-ID: ${selectedPackage!['id']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 8),
                                  Text('Afmetingen: ${selectedPackage!['packageSize']}'),
                                  Text('Gewicht: ${selectedPackage!['weight']} kg'),
                                ],
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredPackages.length,
                            itemBuilder: (BuildContext context, int index) {
                              var package = filteredPackages[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Pakket ID: ${package.id}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 16)),
                                      const SizedBox(height: 8),
                                      Text('Status: ${package.status}'),
                                      Text('Gewicht: ${package.weight} kg'),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/damage',
                                            arguments: package,
                                          );
                                        },
                                        child: const Text('Schade melden'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<DeliveryPackageModel>> _getPackagesWithCoordinates() async {
    List<DeliveryPackageModel> packages = await widget.packagesController.notStartedPackages();
    for (var package in packages) {
      var startLocationJson = await widget.packagesController.apiController.GetData('api/addresses/${package.startLocationId}');
      LatLng startCoordinates = await widget.geocoding.getLatLngFromAddress(jsonEncode(startLocationJson));
      package.latitude = startCoordinates.latitude;
      package.longitude = startCoordinates.longitude;

      var endLocationJson = await widget.packagesController.apiController.GetData('api/addresses/${package.endLocationId}');
      LatLng endCoordinates = await widget.geocoding.getLatLngFromAddress(jsonEncode(endLocationJson));
      package.destinationLatitude = endCoordinates.latitude;
      package.destinationLongitude = endCoordinates.longitude;
    }
    return packages;
  }
}