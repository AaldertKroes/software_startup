import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';

/* Deze view moet 'aangeroepen' worden vanuit een knop op een pakket in
PackagesView. Dan kan het benodigde Package-object meegegeven worden. */
class InsuranceView extends StatefulWidget {
  const InsuranceView({super.key, required this.package});
  final DeliveryPackageModel package;

  @override
  State<InsuranceView> createState() => _InsuranceViewState();
}

class _InsuranceViewState extends State<InsuranceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Verzekeren"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomStyles.insurancePackagesCard(context, widget.package),
            Text(
                "Het verzekeren van dit pakket kost: ${widget.package.shippingPrice! / 4}"),
            TextButton(
                onPressed: () => {},
                child: const Text("Verzekeren")) // TODO: onPressed
          ],
        ),
      ),
    );
  }
}
