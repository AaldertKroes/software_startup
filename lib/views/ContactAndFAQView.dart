import 'package:flutter/material.dart';

class ContactAndFAQView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact & FAQ'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact & FAQ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'FAQ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Wat is Willem Rijdt?\n'
              'Willem rijdt is een particuliere bezorgdienst die staat voor kwalitatieve bezorging aan de klant.\n\n'
              'Waarom kiezen voor Willem?\n'
              'Willem is een snelle, goedkope en betrouwbare bezorgservice die uitgevoerd wordt door en voor klanten.\n\n'
              'Wat zijn de bezorgtijden en kosten van Willem?\n'
              'Dit is zichtbaar in de app, maak een zending aan om de verwachte bezorgtijden en de bijbehorende kosten te zien.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Contact',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'E-mail: William@willemrijdt.nl\n'
              'Telefoon: 050 02398203984',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}