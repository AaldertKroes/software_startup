import 'package:flutter/material.dart';
import 'package:software_startup/controllers/packagescontroller.dart';


class DamageView extends StatelessWidget {
  final PackagesController controller;
  final Map<String, dynamic> package;

  const DamageView({Key? key, required this.controller, required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schade melden')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Heeft je pakket schade opgelopen? Erg vervelend.'),
          SizedBox(height: 10),
          Text('Je kunt het pakket kostenloos retourneren!'),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () async {
              final value = await controller.createReturnPackage(package);
                if (value) {
                  Navigator.pushNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Er is iets misgegaan bij het melden van de schade')),
                  );
                }
              }, child: Text('Pakket retourneren')),
          ],
        ),
      ),
    );
  }
}