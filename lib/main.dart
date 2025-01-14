import 'package:flutter/material.dart';
import 'package:software_startup/controllers/packagescontroller.dart';
import 'package:software_startup/views/ContactAndFAQView.dart';
import 'package:software_startup/views/LoginView.dart';
import 'package:software_startup/views/PackagesView.dart';
import 'package:software_startup/views/ReceiverView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/': (context) => LoginView(),
        '/packages': (context) => PackagesView(),
        '/contact' : (context) => ContactAndFAQView(),
        '/receiver' : (context) => ReceiverPage(controller: PackagesController(baseUrl: 'http://10.0.2.2:8080')),
      },
    );
  }
}

