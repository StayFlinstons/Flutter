import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFFFD700), // Amarelo dourado
          secondary: Color(0xFF00FF00), // Verde
          tertiary: Color(0xFF00A3E0), // Azul claro
          background: Color(0xFF0A1A2C), // Fundo azul escuro
          onBackground: Color(0xFFFFFFFF), // Texto branco
          surface: Color(0xFF0A1A2C), // Superfície (fundo de cards, etc.)
          onSurface: Color(0xFFFFFFFF), // Texto sobre a superfície
        ),
        scaffoldBackgroundColor: const Color(0xFF0A1A2C), // Define o fundo padrão das telas
      ),
      home: const WelcomePage(),
    );
  }
}