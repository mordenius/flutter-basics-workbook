import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Function onChoose;
  
  Answer({this.answerText, this.onChoose});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(this.answerText),
      onPressed: () => this.onChoose(answerText),
    );
  }
}
