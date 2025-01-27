import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';
import 'package:software_startup/controllers/InsuranceController.dart';

/* Deze view moet 'aangeroepen' worden vanuit een knop op een pakket in
PackagesView. Dan kan het benodigde Package-object meegegeven worden. */

class InsuranceView extends StatelessWidget {
  final InsuranceController controller;

  const InsuranceView({super.key, required this.controller});

  String getPriceAsString(dynamic price) {
    var strPrice = price.toString();
    String lastTwo = strPrice.substring(strPrice.length - 2);
    String beforeLastTwo = strPrice.substring(0, strPrice.length - 2);
    if (beforeLastTwo.isEmpty) {
      return "0,$lastTwo";
    } else {
      return "$beforeLastTwo,$lastTwo";
    }
  }

  void _addInsuranceAndNavigate(BuildContext context, userPayment) {
    userPayment["amount"] = userPayment["amount"]+(userPayment["amount"]~/4);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(
            "Verzekering toegevoegd"
        ),
        )
    );
    Navigator.pushNamed(
        context,
        '/sender-payment',
        arguments: <String, dynamic> {
          "userPayment": userPayment,
        }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Verzekeren"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // CustomStyles.insurancePackagesCard(context, widget.package),
            FutureBuilder(
              future: controller.getDeliveryById(args["userPayment"]["packageId"]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (!snapshot.hasData) {
                  return const Text("Geen data");
                } else {
                  return CustomStyles.insurancePackagesCard(context, snapshot.data!);
                }
              }
            ),
            Text(
                "Het verzekeren van dit pakket kost: € ${getPriceAsString(args["userPayment"]['amount']! ~/ 4)}"),
            TextButton(
                onPressed: () => {
                  _addInsuranceAndNavigate(context, args["userPayment"])
                },
                child: const Text("Verzekeren"))
          ],
        ),
      ),
    );
  }
}
