import 'package:flutter/material.dart';
import 'package:software_startup/controllers/PackagesAssignController.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';

class CustomStyles {
  static const backgroundColor = Color(0xfffbfbfb);

  static ButtonStyle willemRijdtButtonStyle = ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll<Color>(Colors.black87),
    fixedSize: const WidgetStatePropertyAll<Size>(Size(300,50)),
    shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
  );

  static ElevatedButton willemRijdtButton(BuildContext context, String text, {String? redirectTo}) => ElevatedButton(
    onPressed: () {redirectTo != null ? Navigator.pushNamed(context, redirectTo) : null;},
    style: CustomStyles.willemRijdtButtonStyle,
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    )
  );

  static TextStyle packageAssignCardTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static Card packagesAssignCard(BuildContext context, PackagesAssignController controller, DeliveryPackageModel package) {
    return Card(
      elevation: 4,
      color: const Color(0xfffbfbfb),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pakket ID: ${package.id.toString()}',
              style: packageAssignCardTextStyle,
            ),
            const SizedBox(height: 8),
            Text("Grootte: ${package.packageSize}"),
            Text("Gewicht: ${package.weight} kg"),
            Text("Afstand: ${package.distance} km"),
            const SizedBox(height: 8),
            Text('Ophalen vanaf: ${package.startLocation}'),
            Text('Bezorgen naar: ${package.endLocation}'),
            ElevatedButton(
              onPressed: () async {
                int assignDriverCheck = await controller.assignAsDriver(package);
                if (context.mounted && assignDriverCheck == 1) Navigator.pushNamed(context, "/home");
              },
              style: CustomStyles.willemRijdtButtonStyle,
              child: const Text(
                "Als bezorger melden",
                style: TextStyle(color: Colors.white),
              )
            ),
          ],
        ),
      ),
    );
  }

  static Card underWayPackageCard(context, package, String eta, callback) {
    return Card(
      child: ListTile(
        title: Text('Pakket ID: ${package['id']}'),
        subtitle: Text(
            'Afstand: ${package['distance']} km\nETA: $eta uur\nGewicht: ${package['weight']} kg'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            callback(context, package);
          },
        ),
      ),
    );
  }
}