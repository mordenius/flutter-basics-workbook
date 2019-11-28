import 'package:flutter/material.dart';

import 'package:flutter_basics_workbook/quiz/quiz.dart';
import 'package:flutter_basics_workbook/expenses_refactor/expenses.dart';

import './theme.dart';

enum Feature { quiz, expenses }

class Curator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CuratorState();
}

class _CuratorState extends State<Curator> {
  Feature _currentFeature;

  void _goTo(Feature feature) {
    setState(() {
      _currentFeature = feature;
    });
  }

  Widget _buildSelector(String name, Feature feature) {
    return RaisedButton(
      child: Text(name),
      onPressed: () {
        _goTo(feature);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentFeature == Feature.quiz) {
      return QuizApp();
    }

    if (_currentFeature == Feature.expenses) {
      return ExpensesApp();
    }

    return MaterialApp(
      theme: curatorTheme,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select feature',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 32,
              ),
              _buildSelector('Quiz', Feature.quiz),
              SizedBox(
                height: 32,
              ),
              _buildSelector('Expenses', Feature.expenses),
            ],
          ),
        ),
      ),
    );
  }
}
