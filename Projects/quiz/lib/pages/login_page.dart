import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    final email = _emailController.text;
    final password = _passwordController.text;

    // Carrega as credenciais registradas
    final prefs = await SharedPreferences.getInstance();
    final registeredEmail = prefs.getString('registeredEmail');
    final registeredPassword = prefs.getString('registeredPassword');
    final registeredUsername = prefs.getString('registeredUsername') ?? 'Usuário';

    // Credenciais fixas como fallback
    const String validEmail = 'teste@teste.com';
    const String validPassword = '123456';
    const String validUsername = 'Usuário Teste';

    bool isValid = false;
    String userName = registeredUsername;

    // Verifica primeiro as credenciais registradas
    if (registeredEmail != null && registeredPassword != null) {
      if (email == registeredEmail && password == registeredPassword) {
        isValid = true;
      }
    }

    // Se não houver credenciais registradas ou não forem válidas, verifica as fixas
    if (!isValid) {
      if (email == validEmail && password == validPassword) {
        isValid = true;
        userName = validUsername;
      }
    }

    if (isValid) {
      // Salva o nome do usuário para uso na QuizHomePage
      await prefs.setString('userName', userName);
      await prefs.setString('userEmail', email);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => QuizHomePage(userName: userName)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou senha incorretos')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  if (!value.contains('@')) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const QuizHomePage(userName: "Usuário Google")),
                  );
                },
                child: const Text('Login com Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}