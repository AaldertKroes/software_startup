import 'package:flutter/material.dart';
import 'package:software_startup/classes/Package.dart';
import 'package:software_startup/common/CustomStyles.dart';

/* Deze view moet 'aangeroepen' worden vanuit een knop op een pakket in
PackagesView. Dan kan het benodigde Package-object meegegeven worden. */
class InsuranceView extends StatefulWidget {
  const InsuranceView({super.key, required this.package});
  final Package package;

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
            CustomStyles.willemRijdtPackageCard(widget.package.id,
                widget.package.status, widget.package.weightGrams,
                packageDesc: widget.package.description),
            //PackageCard(package: widget.package),
            Text(
                "Het verzekeren van dit pakket kost: ${widget.package.shippingPrice / 4}"),
            TextButton(
                onPressed: () => {},
                child: const Text("Verzekeren")) // TODO: onPressed
          ],
        ),
      ),
    );
  }
}
