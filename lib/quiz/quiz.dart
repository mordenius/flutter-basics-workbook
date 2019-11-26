import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './questions.dart';
import './providers/quiz.dart';
import './screens/quiz_screen.dart';

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<Quiz>(
        builder: (_) => Quiz(questions),
        child: QuizScreen(),
      ),
    );
  }
}
