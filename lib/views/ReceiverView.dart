import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:software_startup/controllers/packagescontroller.dart';

class ReceiverPage extends StatefulWidget {
  final PackagesController controller;

  const ReceiverPage({super.key, required this.controller});

  @override
  _ReceiverPageState createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> {
  late Future<List<dynamic>> underwayPackages;
  late PackagesController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    underwayPackages = widget.controller.underwayPackages();
  }

  String calculateETA(int distance) {
    const int averageSpeedKmPerHour = 80;
    double hours = distance / averageSpeedKmPerHour;
    int minutes = (hours * 60).ceil();

    DateTime now = DateTime.now();
    DateTime eta = now.add(Duration(minutes: minutes));

    return DateFormat('HH:mm').format(eta); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakketjes in Bezorging'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: underwayPackages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Fout bij het laden: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Geen pakketjes in bezorging.'));
          } else {
            var packages = snapshot.data!;
            return ListView.builder(
              itemCount: packages.length,
              itemBuilder: (context, index) {
                var package = packages[index];
                var eta = calculateETA(package['distance']);
                return underWayPackageCard(package, eta);
              },
            );
          }
        },
      ),
    );
  }

  void _showReturnPackageConfirmDialog(BuildContext context, package) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Verzeding terugsturen'),
          content: const Text('Weet je zeker dat je de verzending wilt terugsturen?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.createReturnPackageV2(package);
                Navigator.of(context).pop();
              },
              child: const Text(
                'terugsturen',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget underWayPackageCard(package, String eta) {
    return Card(
      child: ListTile(
        title: Text('Pakket ID: ${package['id']}'),
        subtitle: Text(
            'Afstand: ${package['distance']} km\nETA: $eta uur\nGewicht: ${package['weight']} kg'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // Add your button action here
            _showReturnPackageConfirmDialog(context, package);
          },
        ),
      ),
    );
  }
}

