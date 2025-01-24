import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';
import 'package:software_startup/controllers/SenderPaymentController.dart';

class SenderPaymentView extends StatelessWidget {
  final SenderPaymentController controller;
  const SenderPaymentView({super.key, required this.controller});

  Future<void> _payForPackage(BuildContext context, userPayment) async {
    userPayment["status"] = "PAID";
    var response = await controller.payUserPayment(userPayment);

    if (context.mounted) {
      if (response) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
              'Betaaling voltooid!'
          ),
          )
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
                'Betaling mislukt: probeer het later'
            ),
            )
        );
      }
      Navigator.popUntil(
        context,
        ModalRoute.withName('/home'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyles.backgroundColor,
        title: const Text("Zending betalen"),
      ),
      backgroundColor: CustomStyles.backgroundColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text("Betaaloverzicht"),
                const Divider(),
                CustomStyles.infoTile("Te betalen bedrag",
                    "€ ${controller.getPriceAsString(args['userPayment']['amount'])}",
                ),
                const Divider(),
                ElevatedButton(
                  onPressed: () => {
                    _payForPackage(context, args["userPayment"])
                  },
                  style: CustomStyles.willemRijdtButtonStyle,
                  child: const Text(
                    "Betaal",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
