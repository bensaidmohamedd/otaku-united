import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.emoji_events, size: 100, color: Colors.blue),
            Text('Les quiz arrivent bientôt !', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
