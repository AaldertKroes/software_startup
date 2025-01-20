import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:software_startup/common/CustomStyles.dart';
import 'package:software_startup/controllers/packagescontroller.dart';
import 'package:software_startup/views/InsuranceView.dart';

class PackagesView extends StatelessWidget {
  final PackagesController controller =
      PackagesController(baseUrl: 'http://10.0.2.2:8080');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakketten'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: controller.deliveredPackages(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
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
                var package = snapshot.data![index];
                return CustomStyles.willemRijdtPackageCard(
                    package['id'], package['status'], package['weight'],
                    button: TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InsuranceView(id: package['id']))),
                        child: const Text('Verzekeren')));
              },
            );
          }
        },
      ),
    );
  }
}
