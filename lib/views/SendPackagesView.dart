import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';

class SendPackagesView extends StatefulWidget {
  const SendPackagesView({super.key});

  @override
  State<SendPackagesView> createState() => _SendPackagesViewState();
}

class _SendPackagesViewState extends State<SendPackagesView> {
  final _formKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    "packageSize": "",
    "weight": 0,
    "distance": 0,
    "status": "NOT_STARTED",
    "startLocationId": 0,
    "endLocationId": 0,
    "senderId": 0,
    "receiverId": 0,
    "deliveryDriverId": null,
  };
  final Map<String, dynamic> _addressFormData = {
    "street": "",
    "city": "",
    "postalCode": "",
    "county": "The Netherlands",
  };
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyles.backgroundColor,
        title: const Text("Send Packages View"),
      ),
      backgroundColor: CustomStyles.backgroundColor,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: addressForm(),
        ),
      ),
    );
  }

  void _submitAddressForm() {
    if (_addressFormKey.currentState!.validate()) {

    }
  }

  Widget addressForm() {
    return Form(
      key: _addressFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _streetController,
            decoration: const InputDecoration(labelText: 'Straatnaam + huisnummer'),
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
            controller: _cityController,
            decoration: const InputDecoration(labelText: 'Stad'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Voer een stad in";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _postalCodeController,
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitAddressForm,
            child: const Text('Bevestigen'),
          ),
        ],
      ),
    );
  }
}
