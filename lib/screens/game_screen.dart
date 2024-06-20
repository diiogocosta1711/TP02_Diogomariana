import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final String difficulty;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.difficulty,
  });
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Question> questions = [
    // Nível 1: Endereços IP /8, /16 e /24
    Question(
      questionText:
          'Qual é o Network ID do endereço IP 192.168.1.10 com máscara de sub-rede /24?',
      options: ['192.168.1.0', '192.168.1.1', '192.168.1.10', '192.168.0.0'],
      correctAnswer: '192.168.1.0',
      difficulty: 'Nível 1',
    ),
    Question(
      questionText:
          'Qual é o Broadcast do endereço IP 10.0.0.5 com máscara de sub-rede /8?',
      options: ['10.255.255.255', '10.0.0.0', '10.0.0.255', '10.0.255.255'],
      correctAnswer: '10.255.255.255',
      difficulty: 'Nível 1',
    ),
    Question(
      questionText:
          'Os endereços IP 172.16.5.1 e 172.16.10.1 estão no mesmo segmento de rede com máscara de sub-rede /16?',
      options: [
        'Sim, ambos estão na rede 172.16.0.0/16.',
        'Não, estão em redes diferentes.'
      ],
      correctAnswer: 'Sim, ambos estão na rede 172.16.0.0/16.',
      difficulty: 'Nível 1',
    ),
    // Nível 2: Sub-redes
    Question(
      questionText:
          'Qual é o Network ID do endereço IP 192.168.1.130 com máscara de sub-rede 255.255.255.192?',
      options: [
        '192.168.1.128',
        '192.168.1.0',
        '192.168.1.192',
        '192.168.1.64'
      ],
      correctAnswer: '192.168.1.128',
      difficulty: 'Nível 2',
    ),
    Question(
      questionText:
          'Qual é o Broadcast do endereço IP 172.16.4.66 com máscara de sub-rede 255.255.255.240?',
      options: ['172.16.4.79', '172.16.4.0', '172.16.4.255', '172.16.4.16'],
      correctAnswer: '172.16.4.79',
      difficulty: 'Nível 2',
    ),
    Question(
      questionText:
          'Os endereços IP 192.168.2.33 e 192.168.2.65 estão no mesmo segmento de rede com máscara de sub-rede 255.255.255.224?',
      options: [
        'Não, 192.168.2.33 está na rede 192.168.2.32/27 e 192.168.2.65 está na rede 192.168.2.64/27.',
        'Sim, ambos estão na mesma rede.'
      ],
      correctAnswer:
          'Não, 192.168.2.33 está na rede 192.168.2.32/27 e 192.168.2.65 está na rede 192.168.2.64/27.',
      difficulty: 'Nível 2',
    ),
    // Nível 3: Super-redes
    Question(
      questionText:
          'Qual é o Network ID do endereço IP 198.51.100.14 com máscara de sub-rede 255.255.252.0?',
      options: ['198.51.100.0', '198.51.100.1', '198.51.100.14', '198.51.96.0'],
      correctAnswer: '198.51.100.0',
      difficulty: 'Nível 3',
    ),
    Question(
      questionText:
          'Qual é o Broadcast do endereço IP 203.0.113.75 com máscara de sub-rede 255.255.248.0 ou /21?',
      options: [
        '203.0.119.255',
        '203.0.113.255',
        '203.0.115.255',
        '203.0.120.0'
      ],
      correctAnswer: '203.0.119.255',
      difficulty: 'Nível 3',
    ),
    Question(
      questionText:
          'Os endereços IP 192.0.2.35 e 192.0.2.100 estão no mesmo segmento de rede com máscara de sub-rede 255.255.240.0?',
      options: [
        'Sim, ambos estão na mesma rede.',
        'Não, estão em redes diferentes.'
      ],
      correctAnswer: 'Sim, ambos estão na mesma rede.',
      difficulty: 'Nível 3',
    ),
  ];

  int currentQuestionIndex = 0;
  int score = 0;

  void answerQuestion(String answer) {
    if (answer == questions[currentQuestionIndex].correctAnswer) {
      score++;
    }
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= questions.length) {
      final authService = Provider.of<AuthService>(context, listen: false);
      authService.updateScore(score);

      return Scaffold(
        appBar: AppBar(
          title: Text('Game Over'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Game Over! Your score is: $score',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Voltar ao Menu'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('IPv4 Game'),
          actions: [
            IconButton(
              icon: Icon(Icons.leaderboard),
              onPressed: () {
                Navigator.pushNamed(context, '/ranking');
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nível: ${questions[currentQuestionIndex].difficulty}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Consumer<AuthService>(
                builder: (context, authService, child) {
                  return Text(
                    'Pontuação atual: ${score}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                questions[currentQuestionIndex].questionText,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ...questions[currentQuestionIndex].options.map((option) {
                return ElevatedButton(
                  onPressed: () => answerQuestion(option),
                  child: Text(option),
                );
              }).toList(),
            ],
          ),
        ),
      );
    }
  }
}
