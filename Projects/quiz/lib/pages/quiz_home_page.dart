import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz_mode_selection_page.dart';
import 'ranking_page.dart';

class QuizHomePage extends StatefulWidget {
  final String userName;

  const QuizHomePage({super.key, required this.userName});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? widget.userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bem-vindo, $userName')),
      body: Center(
        child: Container(
          color: const Color(0xFF0A1A2C),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/show_do_ismael.png',
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              Container(
                width: 150,
                height: 60,
                 decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 255, 238, 0), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const QuizModeSelectionPage()),
                    );
                  },
                   style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color(0xFF0A1A2C),
                    ),
                  child: const Text(
                    'Jogar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
               Container(
                width: 150,
                height: 60,
                 decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 255, 238, 0), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RankingPage()),
                    );
                  },
                   style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color(0xFF0A1A2C),
                    ),
                  child: const Text(
                    'Ranking',
                    style: TextStyle(fontSize: 18),
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