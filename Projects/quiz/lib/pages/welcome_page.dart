import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo'),
        backgroundColor: const Color(0xFF0A1A2C), // Cor do fundo azul escuro
        foregroundColor: const Color(0xFFFFFFFF), // Texto branco no AppBar
      ),
      body: Container(
        color: const Color(0xFF0A1A2C), // Fundo azul escuro
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/show_do_ismael.png',
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
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
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(
                      color: Color(0xFF0A1A2C), // Azul escuro do fundo
                      fontSize: 20, // Aumenta a fonte
                    ),
                  ),
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
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF0A1A2C), // Azul escuro do fundo
                      fontSize: 20, // Aumenta a fonte
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}