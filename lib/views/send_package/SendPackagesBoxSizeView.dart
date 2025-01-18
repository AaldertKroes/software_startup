import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:software_startup/common/CustomStyles.dart';
import 'package:software_startup/controllers/SendPackageController.dart';

class SendPackagesView extends StatefulWidget {
  const SendPackagesView({super.key});

  @override
  State<SendPackagesView> createState() => _SendPackagesViewState();
}

enum BoxSizes { small, medium, big }

class _SendPackagesViewState extends State<SendPackagesView> {
  final _packageWeightFormKey = GlobalKey<FormState>();

  BoxSizes? selectedBoxSize;
  final _packageWeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyles.backgroundColor,
        title: const Text("Pakket formaat"),
      ),
      backgroundColor: CustomStyles.backgroundColor,
      body: Form(
          key: _packageWeightFormKey,
          child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Selecteer een pakketgrootte:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                // Select package size
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boxSizeSelection(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Pakket gewicht',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: packageWeightFormFields(_packageWeightController),
                ),
                const SizedBox(height: 20),
                // pick-up/sending location
                ElevatedButton(
                  onPressed: _submitPackageSizeForm,
                  style: CustomStyles.willemRijdtButtonStyle,
                  child: const Text(
                    'Volgende',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ),
    );
  }

  void _submitPackageSizeForm() {
    if (_packageWeightFormKey.currentState!.validate()
        && selectedBoxSize != null) {

      //Send selected items to the next view.
      Navigator.pushNamed(
        context,
        '/send_packages/address',
        arguments: <String, dynamic>{
          "packageSize": selectedBoxSize.toString().split('.').last,
          "packageWeight": int.parse(_packageWeightController.text),
          },
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
      direction: Axis.vertical,
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
          label: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Klein'),
              SizedBox(height: 4),
              Text(
                'Max.\n34 x 28 x 12 cm\n€ 3,95',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          icon: Icon(Icons.pallet),
        ),
        ButtonSegment<BoxSizes>(
          value: BoxSizes.medium,
          label: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gemiddeld'),
              SizedBox(height: 4),
              Text(
                'Max.\n100 x 50 x 50 cm\n€ 4,95',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          icon: Icon(Icons.pallet),
        ),
        ButtonSegment<BoxSizes>(
          value: BoxSizes.big,
          label: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Groot'),
              SizedBox(height: 4),
              Text(
                'Max.\n176 x 78 x 58 cm\n€ 12,50',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          icon: Icon(Icons.pallet),
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

  Widget packageWeightFormFields(
      TextEditingController weightController
      ) {
    return TextFormField(
      controller: weightController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // Allow only digits
      ],
      decoration: const InputDecoration(
        labelText: 'Gewicht in hele kilogrammen'
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Voer het gewicht van het pakket in";
        } else if (int.tryParse(value) == null) {
          return "Voer het gewicht in hele killogrammen in.";
        }
        return null;
      }
    );
  }
}
