import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:software_startup/common/CustomStyles.dart';
import 'package:software_startup/controllers/packagescontroller.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';
import 'package:software_startup/views/InsuranceView.dart';

class PackagesView extends StatefulWidget {
  final PackagesController controller;

  const PackagesView({Key? key, required this.controller}) : super(key: key);

  @override
  _PackagesViewState createState() => _PackagesViewState();
}

class _PackagesViewState extends State<PackagesView> {
  late Future<List<dynamic>> deliveredPackages;

  @override
  void initState() {
    super.initState();
    deliveredPackages = widget.controller.deliveredPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakketten'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: deliveredPackages,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Fout bij ophalen van pakketten: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Geen pakketten beschikbaar.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var package =
                    DeliveryPackageModel.fromJson(snapshot.data![index]);
                return CustomStyles.willemRijdtPackageCard(
                    package.id, package.status, package.weight,
                    button: TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InsuranceView(id: package.id))),
                        child: const Text('Verzekeren')));
              },
            );
          }
        },
      ),
    );
  }
}
