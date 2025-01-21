import 'package:flutter/material.dart';
import 'package:software_startup/views/HomeView.dart';
import 'package:software_startup/views/LoginView.dart';
import 'package:software_startup/views/PackagesView.dart';
import 'package:software_startup/views/MapView.dart';
import 'package:software_startup/controllers/authcontroller.dart';

void main() {
  const String baseUrl = 'http://10.0.2.2:8080/api';
  runApp(const MyApp(baseUrl: baseUrl));
}

class MyApp extends StatelessWidget {
  final String baseUrl;
  const MyApp({super.key, required this.baseUrl});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Willem rijdt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(AuthController: AuthController(baseUrl: baseUrl)),
        '/home': (context) => const HomeView(),
        '/packages': (context) => PackagesView(),
        '/packages_map': (context) => PackagesMapView(),
      },
    );
  }
}

