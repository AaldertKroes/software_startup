import 'package:flutter/material.dart';
import 'package:software_startup/controllers/packagescontroller.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';

class DamageView extends StatelessWidget {
  final PackagesController controller;
  final DeliveryPackageModel package;

  const DamageView({super.key, required this.controller, required this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schade melden')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Heeft je pakket schade opgelopen? Erg vervelend.'),
          const SizedBox(height: 10),
          const Text('Je kunt het pakket kostenloos retourneren!'),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () async {
              final value = await controller.createReturnPackage(package);
              if (context.mounted) {
                if (value) {
                  Navigator.pushNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(
                        'Er is iets misgegaan bij het melden van de schade')),
                  );
                }
              }
              }, child: const Text('Pakket retourneren')),
          ],
        ),
      ),
    );
  }
}