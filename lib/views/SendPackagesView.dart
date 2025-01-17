import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';

class SendPackagesView extends StatefulWidget {
  const SendPackagesView({super.key});

  @override
  State<SendPackagesView> createState() => _SendPackagesViewState();
}

enum BoxSizes { small, medium, big }
BoxSizes boxSizes = BoxSizes.small;

class _SendPackagesViewState extends State<SendPackagesView> {
  final _formKey = GlobalKey<FormState>();
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
  BoxSizes? selectedBoxSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyles.backgroundColor,
        title: const Text("Send Packages View"),
      ),
      backgroundColor: CustomStyles.backgroundColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Selecteer een pakketgrootte:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: boxSizeSelection(),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: addressForm(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              style: CustomStyles.willemRijdtButtonStyle,
              child: const Text(
                'Bevestigen',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        )
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && selectedBoxSize != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Great succes!')),
      );
    }
    if (selectedBoxSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecteer pakketgrootte')),
      );
    }
  }

  Widget boxSizeSelection() {
    return SegmentedButton(
      emptySelectionAllowed: true,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Makes the border square
          ),
        ),
      ),
      segments: const <ButtonSegment<BoxSizes>>[
        ButtonSegment<BoxSizes>(
          value: BoxSizes.small,
          label: Text('Klein pakket'),
        ),
        ButtonSegment<BoxSizes>(
          value: BoxSizes.medium,
          label: Text('Gemiddeld pakket'),
        ),
        ButtonSegment<BoxSizes>(
          value: BoxSizes.big,
          label: Text('Groot pakket'),
        ),
      ],
      selected: selectedBoxSize != null ? <BoxSizes>{selectedBoxSize!} : <BoxSizes>{},
      onSelectionChanged: (Set<BoxSizes> newSelection) {
        setState(() {
          selectedBoxSize = newSelection.isNotEmpty ? newSelection.first : null;
        });
      },
    );
  }

  Widget addressForm() {
    return Column(
      children: [
        TextFormField(
          controller: _streetController,
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
      ],
    );
  }
}
