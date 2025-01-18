import 'package:flutter/material.dart';
import 'package:software_startup/views/ContactAndFAQView.dart';
import 'package:software_startup/views/HomeView.dart';
import 'package:software_startup/views/LoginView.dart';
import 'package:software_startup/views/PackagesView.dart';

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
        '/home': (context) => const HomeView(),
        '/packages': (context) => PackagesView(),
        '/contact' : (context) => ContactAndFAQView(),
      },
    );
  }
}

