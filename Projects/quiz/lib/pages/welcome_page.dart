import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A2C), // Fundo azul escuro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo pequena acima dos botões
            Image.asset(
              'assets/show_do_ismael.png',
              width: 400, // Tamanho reduzido
              height: 400,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40), // Espaçamento entre logo e botões
            SizedBox(
              width: 150,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700), // Amarelo dourado
                  foregroundColor: const Color(0xFFFFFFFF), // Branco
                ),
                child: const Text('Registrar'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700), // Amarelo dourado
                  foregroundColor: const Color(0xFFFFFFFF), // Branco
                ),
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}