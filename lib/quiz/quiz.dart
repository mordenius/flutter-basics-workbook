import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/quiz.provider.dart';

import './theme.dart';

import './screens/start_screen.dart';
import './screens/result_screen.dart';
import './screens/quiz_screen.dart';

import './questions.dart';

class QuizApp extends StatelessWidget {
  static final List<SingleChildCloneableWidget> _providers = [
    ChangeNotifierProvider.value(value: Quiz(questions)),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: MaterialApp(
        theme: quizTheme,
        home: _QuizApp(),
      ),
    );
  }
}

class _QuizApp extends StatelessWidget {
  static final Map<QuizStage, Widget> _routes = {
    QuizStage.start: StartScreen(),
    QuizStage.progress: QuizScreen(),
    QuizStage.result: ResultScreen(),
  };

  @override
  Widget build(BuildContext context) {
    QuizStage currentStage = Provider.of<Quiz>(context).currentStage;
    return Scaffold(
      body: _routes[currentStage],
    );
  }
}
