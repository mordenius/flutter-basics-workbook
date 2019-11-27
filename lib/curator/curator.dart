import 'package:flutter/material.dart';

import 'package:flutter_basics_workbook/quiz/quiz.dart';

enum Feature { quiz }

class Curator extends StatefulWidget {
  Feature _currentFeature;

  @override
  State<StatefulWidget> createState() => _CuratorState();
}

class _CuratorState extends State<Curator> {
  void _goTo(Feature feature) {
    setState(() {
      widget._currentFeature = feature;
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
    if (widget._currentFeature == Feature.quiz) {
      return QuizApp();
    }

    return MaterialApp(
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
            ],
          ),
        ),
      ),
    );
  }
}
