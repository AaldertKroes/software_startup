import 'package:flutter/material.dart';
import 'package:software_startup/classes/Package.dart';

class PackageCard extends StatelessWidget {
  final Package package;
  const PackageCard({super.key, required this.package});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pakket-ID: ${package.id}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text('Beschrijving: ${package.description}'),
            Text('Status: ${package.status}'),
            Text('Gewicht: ${package.weight} kg'),
          ],
        ),
      ),
    );
  }
}
