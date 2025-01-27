import 'package:flutter/material.dart';
import 'package:software_startup/core/DependencyContainer.dart';
import 'package:software_startup/core/Routes.dart';

void main() {
  final di = DependencyContainer();
  di.init();

  runApp(MyApp(di: di));
}

class MyApp extends StatelessWidget {
  final DependencyContainer di;
  const MyApp({super.key, required this.di});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Willem rijdt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: appRoutes(di),
    );
  }
}

