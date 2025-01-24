import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';
import 'package:software_startup/controllers/packagescontroller.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';

class PackagesView extends StatefulWidget {
  final PackagesController controller;

  const PackagesView({Key? key, required this.controller}) : super(key: key);

  @override
  _PackagesViewState createState() => _PackagesViewState();
}

class _PackagesViewState extends State<PackagesView> {
  @override
  void initState() => super.initState();

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakketten'),
      ),
      body: FutureBuilder<List<DeliveryPackageModel>>(
        future: widget.controller.deliveredPackages(),
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
                var package = snapshot.data![index];
                return CustomStyles.deliveredPackagesCard(context, package);
              },
            );
          }
        },
      ),
    );
  }
  
}
