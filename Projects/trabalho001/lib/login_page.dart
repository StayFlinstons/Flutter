import 'package:flutter/material.dart';
import 'package:trabalho001/app_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IsmaelFOOD'), actions: [CustomSwitcher()]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                onChanged: (text) {
                  email = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                onChanged: (text) {
                  password = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (email == 'teste' && password == '123') {
                  // Navigator.of(context).pushReplacementNamed('/home');
                } else {}
              },
              child: Text('Login'),
            ),
            TextButton(onPressed: () {
              Navigator.pushNamed(context, '/signin');
            }, child: Text('Registrar')),
          ],
        ),
      ),
    );
  }
}
