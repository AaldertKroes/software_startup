import 'package:flutter/material.dart';

class PackagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Packages View')),
      body: Center(
        child: Column(
        children: <Widget>[
        Text('Welkom op de Packages Page!'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/packages_map');
            },
            child: Text('Bekijk pakketten op kaart'),
          ),
        ],
        ),
      ),
    );
  }
}
