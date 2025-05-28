
import 'package:flutter/material.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados simulados
    final rankings = [
      {'name': 'João', 'score': 9},
      {'name': 'Maria', 'score': 8},
      {'name': 'Pedro', 'score': 7},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Ranking')),
      body: ListView.builder(
        itemCount: rankings.length,
        itemBuilder: (context, index) {
          final user = rankings[index];
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(user['name'].toString()),
            trailing: Text('Acertos: ${user['score']}'),
          );
        },
      ),
    );
  }
}
