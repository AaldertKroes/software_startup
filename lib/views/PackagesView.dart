import 'package:flutter/material.dart';
import 'package:software_startup/controllers/packagescontroller.dart';

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
                var package = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pakket ID: ${package.id}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Status: ${package.status}'),
                        Text('Gewicht: ${package.weight} kg'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/damage',
                              arguments: package,
                            );
                          },
                          child: const Text('Schade melden'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
  
}
