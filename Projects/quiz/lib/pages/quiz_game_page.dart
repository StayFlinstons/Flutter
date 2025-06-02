import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';

class QuizGamePage extends StatefulWidget {
  final String category;
  final int totalQuestions;

  const QuizGamePage({super.key, required this.category, required this.totalQuestions});

  @override
  State<QuizGamePage> createState() => _QuizGamePageState();
}

class _QuizGamePageState extends State<QuizGamePage> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool? isCorrect;
  bool answered = false;
  List<Map<String, dynamic>> questions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      String jsonString = await rootBundle.loadString('assets/questions.json');
      Map<String, dynamic> jsonData = json.decode(jsonString);
      
      String categoryKey = widget.category.toLowerCase();
      
      Map<String, String> categoryMap = {
        'geral': 'geral',
        'história': 'historia',
        'ciência': 'ciencia',
        'esportes': 'esportes',
        'matemática': 'matematica',
      };
      
      String jsonKey = categoryMap[categoryKey] ?? 'geral';
      
      List<dynamic> categoryQuestions = jsonData[jsonKey] ?? [];
      
      categoryQuestions.shuffle(Random());
      
      setState(() {
        questions = categoryQuestions
            .take(widget.totalQuestions)
            .cast<Map<String, dynamic>>()
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        questions = [
          {
            'question': 'Qual é a capital da França?',
            'options': ['Berlim', 'Madri', 'Paris', 'Roma'],
            'answer': 'Paris',
            'explanation': 'Paris é a capital e cidade mais populosa da França.',
          },
          {
            'question': '2 + 2 é igual a?',
            'options': ['3', '4', '5', '6'],
            'answer': '4',
            'explanation': '2 + 2 = 4.',
          }
        ];
        isLoading = false;
      });
      print('Erro ao carregar perguntas: $e');
    }
  }

  void checkAnswer(String selected) {
    setState(() {
      answered = true;
      isCorrect = selected == questions[currentQuestionIndex]['answer'];
      if (isCorrect!) score++;
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        answered = false;
        isCorrect = null;
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Quiz Finalizado!'),
            content: Text('Você acertou $score de ${questions.length} perguntas!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Carregando...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: const Center(
          child: Text('Não foi possível carregar as perguntas.'),
        ),
      );
    }

    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} - Pergunta ${currentQuestionIndex + 1}/${questions.length}'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(label: Text('Pontuação: $score')),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 20),
            Text(
              question['question'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...question['options'].map<Widget>((opt) {
              Color? backgroundColor;
              if (answered) {
                if (opt == question['answer']) {
                  backgroundColor = Colors.green.withOpacity(0.6);
                } else {
                  backgroundColor = Colors.grey.shade300;
                }
              } else {
                backgroundColor = Colors.white;
              }

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: ListTile(
                  title: Text(
                    opt,
                    style: const TextStyle(
                      color:  Color(0xFF0A1A2C),
                      fontSize: 20
                    ),
                  ),
                  onTap: answered ? null : () => checkAnswer(opt),
                ),
              );
            }).toList(),
            if (answered) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isCorrect! ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      isCorrect! ? Icons.check_circle : Icons.cancel,
                      color: isCorrect! ? Colors.green : Colors.red,
                      size: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isCorrect! ? 'Correto!' : 'Incorreto!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isCorrect! ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question['explanation'],
                      style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 150,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: answered ? nextQuestion : null,
                    child: Text(
                      currentQuestionIndex == questions.length - 1 ? 'Finalizar' : 'Próxima',
                      style: const TextStyle(fontSize: 18), // Aumenta a fonte
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}