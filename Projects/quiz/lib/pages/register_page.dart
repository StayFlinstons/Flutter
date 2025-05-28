
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Nome de usuário')),
            const TextField(decoration: InputDecoration(labelText: 'Email')),
            const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Senha')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Registrar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Simula registro com Google
                Navigator.pop(context);
              },
              child: const Text('Registrar com Google'),
            ),
          ],
        ),
      ),
    );
  }
}
