import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';

class SendPackagesAddress extends StatefulWidget {
  const SendPackagesAddress({super.key});

  @override
  State<SendPackagesAddress> createState() => _SendPackagesAddressState();
}

class _SendPackagesAddressState extends State<SendPackagesAddress> {
  final _packageAddressFormKey = GlobalKey<FormState>();

  final _recipientStreetController = TextEditingController();
  final _recipientCityController = TextEditingController();
  final _recipientPostalCodeController = TextEditingController();

  final _senderStreetController = TextEditingController();
  final _senderCityController = TextEditingController();
  final _senderPostalCodeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyles.backgroundColor,
        title: const Text("Ophaal & bezorgadres"),
      ),
      backgroundColor: CustomStyles.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: _packageAddressFormKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                  "Bezorgadres invullen",
                  style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: addressFormFields(_recipientStreetController,
                _recipientCityController,
                _recipientPostalCodeController),
              ),
              const SizedBox(height: 20),
              const Text(
                "Ophaaladres invullen",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: addressFormFields(_senderStreetController,
                    _senderCityController,
                    _senderPostalCodeController),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitPackageAddressForm,
                style: CustomStyles.willemRijdtButtonStyle,
                child: const Text(
                  'Volgende',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  void _submitPackageAddressForm() {
    if (_packageAddressFormKey.currentState!.validate()) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

      args["recipientStreet"] = _recipientStreetController.text;
      args["recipientCity"] = _recipientCityController.text;
      args["recipientPostalCode"] = _recipientPostalCodeController.text;
      args["senderStreet"] = _senderStreetController.text;
      args["senderCity"] = _senderCityController.text;
      args["senderPostalCode"] = _senderPostalCodeController.text;

      Navigator.pushNamed(
        context,
        '/send_packages/recipient',
        arguments: args,
      );
    }
  }

  Widget addressFormFields(
      TextEditingController streetController,
      TextEditingController cityController,
      TextEditingController postalController,
      ) {
    return Column(
      children: [
        TextFormField(
          controller: streetController,
          decoration: const InputDecoration(
              labelText: 'Straatnaam + huisnummer'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Voer een straat en huisnummer in";
            } else if (!RegExp(r'^[A-Za-z\s]+ \d+$').hasMatch(value)) {
              return "Voer een geldige straat en huisnummer in";
            }
            return null;
          },
        ),
        TextFormField(
          controller: cityController,
          decoration: const InputDecoration(labelText: 'Stad'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Voer een stad in";
            }
            return null;
          },
        ),
        TextFormField(
          controller: postalController,
          decoration: const InputDecoration(labelText: 'Postcode'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Voer een postcode in";
            } else if (!RegExp(r'^\d{4}\s?[A-Za-z]{2}$').hasMatch(value)) {
              return "Voer een geldige postcode in. (bijv. '1234 AB')";
            }
            return null;
          },
        ),
      ],
    );
  }
}
