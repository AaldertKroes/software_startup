import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';

class SendPackagesRecipient extends StatefulWidget {
  const SendPackagesRecipient({super.key});

  @override
  State<SendPackagesRecipient> createState() => _SendPackagesRecipientState();
}

class _SendPackagesRecipientState extends State<SendPackagesRecipient> {
  final _packageRecipientFormKey = GlobalKey<FormState>();

  final _recipientFirstNameController = TextEditingController();
  final _recipientLastNameController = TextEditingController();
  final _recipientEmailNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyles.backgroundColor,
        title: const Text("Pakket formaat"),
      ),
      backgroundColor: CustomStyles.backgroundColor,
      body: Form(
        key: _packageRecipientFormKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Informatie ontvanger invullen",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: recipientInformationFormFields(
                  _recipientFirstNameController,
                  _recipientLastNameController,
                  _recipientEmailNameController
              ),
            ),
            ElevatedButton(
              onPressed: _submitPackageRecipientForm,
              style: CustomStyles.willemRijdtButtonStyle,
              child: const Text(
                'Volgende',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPackageRecipientForm() {
    if (_packageRecipientFormKey.currentState!.validate()) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

      args["recipientFirstName"] = _recipientFirstNameController.text;
      args["recipientLastName"] = _recipientLastNameController.text;
      args["recipientEmail"] = _recipientEmailNameController.text;

      Navigator.pushNamed(
        context,
        '/send_packages/confirm',
        arguments: args,
      );
    }
  }

  Widget recipientInformationFormFields(
      TextEditingController firstNameController,
      TextEditingController lastNameController,
      TextEditingController emailController,
      ) {
    return Column(
      children: [
          TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(
                labelText: 'Voornaam'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Voer een voornaam in";
              }
              return null;
            },
          ),
          const SizedBox(width: 10,),
          TextFormField(
            controller: lastNameController,
            decoration: const InputDecoration(
                labelText: 'Achternaam'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Voer een achternaam in";
              }
              return null;
            },
          ),
        const SizedBox(height: 20),
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
              labelText: 'E-mailadres'),
          validator: (value) {
            final RegExp emailRegex =
            RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

            if (value == null || value.isEmpty) {
              return "Vul een e-mailadres in";
            } else if (!emailRegex.hasMatch(value)) {
              return "Vul een geldig e-mailadres in";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
