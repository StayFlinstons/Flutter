import 'package:flutter/material.dart';
import 'package:trabalho001/app_controller.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String email = '';
  String password = '';
  String name = '';

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
                  name = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Nome',
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
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
