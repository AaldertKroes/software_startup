import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:software_startup/controllers/packagescontroller.dart';

class ReceiverPage extends StatefulWidget {
  final PackagesController controller;

  const ReceiverPage({Key? key, required this.controller}) : super(key: key);

  @override
  _ReceiverPageState createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> {
  late Future<List<dynamic>> underwayPackages;

  @override
  void initState() {
    super.initState();
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
          }

          var packages = snapshot.data!;
          return ListView.builder(
            itemCount: packages.length,
            itemBuilder: (context, index) {
              var package = packages[index];
              var eta = calculateETA(package['distance']);
              return Card(
                child: ListTile(
                  title: Text('Pakket ID: ${package['id']}'),
                  subtitle: Text('Afstand: ${package['distance']} km\nETA: $eta uur\nGewicht: ${package['weight']} kg'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

