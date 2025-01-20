import 'package:flutter/material.dart';
import 'package:software_startup/classes/Package.dart';

class CustomStyles {
  static ButtonStyle willemRijdtButtonStyle = ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll<Color>(Colors.black87),
      fixedSize: const WidgetStatePropertyAll<Size>(Size(300, 50)),
      shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))));

  static ElevatedButton willemRijdtButton(BuildContext context, String text,
          {String? redirectTo}) =>
      ElevatedButton(
          onPressed: () {
            redirectTo != null
                ? Navigator.pushNamed(context, redirectTo)
                : null;
          },
          style: CustomStyles.willemRijdtButtonStyle,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ));

  static Card willemRijdtPackageCard(
          int packageId, String packageStatus, int packageWeightGrams,
          {String packageDesc = '', Widget? button}) =>
      Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pakket-ID: $packageId',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                if (packageDesc != '') Text('Beschrijving: $packageDesc'),
                Text('Status: $packageStatus'),
                Text('Gewicht: ${packageWeightGrams * 1000} kg'),
                if (button != null) button,
              ],
            ),
          ));
}
