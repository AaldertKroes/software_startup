import 'package:flutter/material.dart';
import 'package:software_startup/controllers/authcontroller.dart';

class LoginView extends StatelessWidget {
  final Authcontroller authController;

  LoginView({Key? key, required this.authController}) : super(key: key);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Login',
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  authController.login(usernameController.text, passwordController.text).then((value) {
                    if (value) {
                      Navigator.pushNamed(context, '/map');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid username or password')),
                      );
                    }
                  });
                },
                child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}