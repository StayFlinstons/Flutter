
import 'package:flutter/material.dart';
import 'quiz_mode_selection_page.dart';
import 'ranking_page.dart';

class QuizHomePage extends StatelessWidget {
  final String userName;

  const QuizHomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bem-vindo, \$userName')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const QuizModeSelectionPage()));
              },
              child: const Text('Jogar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RankingPage()));
              },
              child: const Text('Ranking'),
            ),
          ],
        ),
      ),
    );
  }
}
