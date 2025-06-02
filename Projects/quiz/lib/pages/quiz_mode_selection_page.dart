import 'package:flutter/material.dart';
import 'quiz_game_page.dart';

class QuizModeSelectionPage extends StatefulWidget {
  const QuizModeSelectionPage({super.key});

  @override
  State<QuizModeSelectionPage> createState() => _QuizModeSelectionPageState();
}

class _QuizModeSelectionPageState extends State<QuizModeSelectionPage> {
  String selectedCategory = 'Geral';
  int selectedQuestions = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          color: const Color(0xFF0A1A2C),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Selecionar Modo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFD700),
                  ),
                ),
                const SizedBox(height: 30),
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (value) {
                    if (value != null) setState(() => selectedCategory = value);
                  },
                  items: ['Geral', 'História', 'Ciência', 'Esportes']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                ),
                const SizedBox(height: 20),
                DropdownButton<int>(
                  value: selectedQuestions,
                  onChanged: (value) {
                    if (value != null) setState(() => selectedQuestions = value);
                  },
                  items: [10, 15, 20]
                      .map((e) => DropdownMenuItem(value: e, child: Text('$e perguntas')))
                      .toList(),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 150,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => QuizGamePage(
                          category: selectedCategory,
                          totalQuestions: selectedQuestions,
                        ),
                      ));
                    },
                    child: const Text(
                      'Iniciar Quiz',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}