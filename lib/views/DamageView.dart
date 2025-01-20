import 'package:flutter/material.dart';

class DamageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Damage View')),
      body: Center(
        child: Column(
        children: <Widget>[
        Text('Welkom op de Damage Page!'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/damage_map');
            },
            child: Text('Bekijk schade op kaart'),
          ),
        ],
        ),
      ),
    );
  }
}