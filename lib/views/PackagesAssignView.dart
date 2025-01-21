import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';
import 'package:software_startup/controllers/PackagesAssignController.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';

class PackagesAssignView extends StatefulWidget {
  final PackagesAssignController controller;

  const PackagesAssignView({
    super.key,
    required this.controller
  });

  @override
  _PackagesAssignViewState createState() => _PackagesAssignViewState();
}

class _PackagesAssignViewState extends State<PackagesAssignView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pakket aanmelden")),
      backgroundColor: const Color(0xfffbfbfb),
      body: Center(
        child: FutureBuilder(
          future: widget.controller.getPackages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final List<DeliveryPackageModel> packages = snapshot.data!;
              return ListView.builder(
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  return CustomStyles.packagesAssignCard(context, widget.controller, packages[index]);
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        ),
      ),
    );
  }
}