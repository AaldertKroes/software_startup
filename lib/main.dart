import 'package:flutter/material.dart';
import 'package:software_startup/controllers/packagescontroller.dart';
import 'package:software_startup/views/ContactAndFAQView.dart';
import 'package:software_startup/views/HomeView.dart';
import 'package:software_startup/views/LoginView.dart';
import 'package:software_startup/views/PackagesView.dart';
import 'package:software_startup/views/ReceiverView.dart';
import 'package:software_startup/controllers/authcontroller.dart';
import 'package:software_startup/controllers/apicontroller.dart';
import 'package:software_startup/views/DamageView.dart';
import 'package:software_startup/views/MapView.dart';

void main() {
  const String baseUrl = 'https://3b85-145-33-102-21.ngrok-free.app';
  final apiController = ApiController(baseUrl: baseUrl);
  runApp(MyApp(baseUrl: baseUrl, apiController: apiController));
}

class MyApp extends StatelessWidget {
  final String baseUrl;
  final ApiController apiController;
  const MyApp({super.key, required this.baseUrl, required this.apiController});

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
        '/': (context) => LoginView(authController: Authcontroller(baseUrl: baseUrl)),
        '/home': (context) => const HomeView(),
        '/packages': (context) => PackagesView(controller: PackagesController(baseUrl: baseUrl, apiController: apiController)),
        '/contact' : (context) => ContactAndFAQView(),
        '/receiver' : (context) => ReceiverPage(controller: PackagesController(baseUrl: baseUrl, apiController: apiController)),
        '/map' : (context) => PackagesMapView(controller: PackagesController(baseUrl: baseUrl, apiController: apiController)),
        '/damage' : (context) {
          final package = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return DamageView(controller: PackagesController(baseUrl: baseUrl, apiController: apiController), package: package);
      },
    },
    );
  }
}

