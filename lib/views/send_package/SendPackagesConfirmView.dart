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

    bool response = await _sendPackageController.submitNewDelivery(args);

    if (response == false) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
              'Bevestiging mislukt: '
                  'probeer het op een ander moment weer'
          ),
          )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
              'Bevestiging geslaagd!'
          ),
          )
      );
    }
    if (mounted) {
      Navigator.pushNamed(
        context,
        '/home',
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
                InfoTile(label: "Formaat", value: args["packageSize"]),
                InfoTile(label: "Gewicht", value: args["packageWeight"]),
                InfoTile(label: "Kosten", value: "€ ${args["paymentAmount"]}".replaceAll('.', ',')),
                const Divider(),
                const Text("Ontvanger"),
                InfoTile(label: "Straat", value: args["recipientStreet"]),
                InfoTile(label: "Stad", value: args["recipientCity"]),
                InfoTile(label: "Postcode", value: args["recipientPostalCode"]),
                InfoTile(label: "Naam", value: args["recipientFirstName"]),
                InfoTile(label: "Achternaam", value: args["recipientLastName"]),
                InfoTile(label: "Emailadres", value: args["recipientEmail"]),
                const Divider(),
                const Text("Verstuurder"),
                InfoTile(label: "Sender Street", value: args["senderStreet"]),
                InfoTile(label: "Sender City", value: args["senderCity"]),
                InfoTile(label: "Sender Postal Code", value: args["senderPostalCode"]),
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
        ],
        ),
      );
  }
}

class InfoTile extends StatelessWidget {
  final String label;
  final dynamic value;

  const InfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("$value"),
        ],
      ),
    );
  }
}
