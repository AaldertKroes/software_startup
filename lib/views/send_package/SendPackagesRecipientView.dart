import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';
import 'package:software_startup/controllers/SendPackageController.dart';

class SendPackagesRecipient extends StatefulWidget {
  const SendPackagesRecipient({super.key});

  @override
  State<SendPackagesRecipient> createState() => _SendPackagesRecipientState();
}

class _SendPackagesRecipientState extends State<SendPackagesRecipient> {
  final SendPackageController _sendPackageController = SendPackageController();

  Future<void> sendPackage() async {
    final args = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<String, dynamic>;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyles.backgroundColor,
        title: const Text("Bevestig verzending"),
      ),
      backgroundColor: CustomStyles.backgroundColor,
      body: Column(
        children: [
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
