import 'package:flutter/material.dart';
import 'package:software_startup/models/Package.dart';

class PackagesController {
  List<Package> getPackages() {
    // Hier zou je normaal gesproken data ophalen van een API
    return [
      Package(id: '1', name: 'Pakket 1', latitude: 52.370216, longitude: 4.895168),
      Package(id: '2', name: 'Pakket 2', latitude: 50.9225, longitude: 4.47917),
      Package(id: '3', name: 'Pakket 3', latitude: 53.196, longitude: 6.577),
      Package(id: '4', name: "Pakket 4", latitude: 53.217, longitude: 6.564),
      Package(id: '5', name: "Pakket 5", latitude: 53.233, longitude: 6.537),
      // Voeg meer pakketten toe
    ];
  }
}