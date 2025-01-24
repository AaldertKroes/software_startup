import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';
import 'package:software_startup/controllers/SendPackageController.dart';

class SendPackagesConfirm extends StatefulWidget {
  const SendPackagesConfirm({super.key});

  @override
  State<SendPackagesConfirm> createState() => _SendPackagesConfirmState();
}

class _SendPackagesConfirmState extends State<SendPackagesConfirm> {
  final SendPackageController _sendPackageController = SendPackageController();

  Future<void> sendPackage() async {
    final Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    dynamic response = await _sendPackageController.submitNewDelivery(args);

    if (mounted) {
      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
                'Bevestiging geslaagd!'
            ),
            )
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
                'Bevestiging mislukt: probeer het op een ander moment weer'
            ),
            )
        );
      }
      Navigator.pushNamed(
        context,
        '/sender-payment',
        arguments: <String, dynamic> {
          "userPayment": response,
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyles.backgroundColor,
        title: const Text("Bevestig verzending"),
      ),
      backgroundColor: CustomStyles.backgroundColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Divider(),
                const Text("Pakket"),
                CustomStyles.infoTile("Formaat", args["packageSize"]),
                CustomStyles.infoTile("Gewicht", args["packageWeight"]),
                CustomStyles.infoTile("Kosten", "€ ${_sendPackageController.getPriceAsString(args["paymentAmount"])}"),
                const Divider(),
                const Text("Ontvanger"),
                CustomStyles.infoTile("Straat", args["recipientStreet"]),
                CustomStyles.infoTile("Stad", args["recipientCity"]),
                CustomStyles.infoTile("Postcode", args["recipientPostalCode"]),
                CustomStyles.infoTile("Naam", args["recipientFirstName"]),
                CustomStyles.infoTile("Achternaam", args["recipientLastName"]),
                CustomStyles.infoTile("Emailadres", args["recipientEmail"]),
                const Divider(),
                const Text("Verstuurder"),
                CustomStyles.infoTile("Sender Street", args["senderStreet"]),
                CustomStyles.infoTile("Sender City", args["senderCity"]),
                CustomStyles.infoTile("Sender Postal Code", args["senderPostalCode"]),
                const Divider(),
                ],
            )
          ),
          ElevatedButton(
            onPressed: sendPackage,
            style: CustomStyles.willemRijdtButtonStyle,
            child: const Text(
              "Bevestig verzending",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => {
              if (mounted) {
                Navigator.popUntil(
                context,
                ModalRoute.withName('/home'),
                )
              }
            },
            style: CustomStyles.willemRijdtButtonStyle,
            child: const Text(
              "Annuleer verzending",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        ),
      );
  }
}
