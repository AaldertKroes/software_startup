import 'package:flutter/material.dart';
import 'package:software_startup/controllers/AuthController.dart';

class RegisterView extends StatelessWidget {
  final AuthController authController;

  RegisterView({Key? key, required this.authController}) : super(key: key);

  final loginController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Register New Account'),
            TextField(
              controller: loginController,
              decoration: const InputDecoration(labelText: "Login (Username)"),
            ),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: "First Name"),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: "Last Name"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                authController.register(
                  loginController.text,
                  firstNameController.text,
                  lastNameController.text,
                  emailController.text,
                  passwordController.text,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registration successful, activation email sent')),
                );

                Navigator.pushNamed(context, '/');
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}



