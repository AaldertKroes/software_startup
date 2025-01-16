import 'package:flutter/material.dart';
import 'package:software_startup/common/CustomStyles.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            const Center(
              child: Image(
                image: AssetImage('assets/willem-rijdt-logo.png'),
                width: 300,
                height: 300,
              ),
            ),
            Center(
              child: Container(
                height: 300,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Pas de routes aan wanneer de pagina's aangemaakt worden
                    CustomStyles.willemRijdtButton(context, "Pakketten volgen", "/package"),
                    CustomStyles.willemRijdtButton(context, "Verstuur pakketje", "/package/send"),
                    CustomStyles.willemRijdtButton(context, "Geschiedenis bekijken", "/history"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
