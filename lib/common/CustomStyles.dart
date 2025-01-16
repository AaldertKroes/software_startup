import 'package:flutter/material.dart';

class CustomStyles {
  static ButtonStyle willemRijdtButtonStyle = ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll<Color>(Colors.black87),
    fixedSize: const WidgetStatePropertyAll<Size>(Size(300,50)),
    shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
  );

  static ElevatedButton willemRijdtButton(BuildContext context, String text, {String? redirectTo}) => ElevatedButton(
    onPressed: () {redirectTo != null ? Navigator.pushNamed(context, redirectTo) : null;},
    style: CustomStyles.willemRijdtButtonStyle,
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    )
  );
}