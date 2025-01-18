import 'package:flutter/material.dart';
import 'package:software_startup/controllers/authcontroller.dart';
import 'package:software_startup/views/PackagesView.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final authcontroller = Authcontroller(baseUrl: 'https://fb32-178-84-112-235.ngrok-free.app/api');
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
                  authcontroller.login(usernameController.text, passwordController.text).then((value) {
                    if (value == true) {
                      Navigator.pushNamed(context, '/home');
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