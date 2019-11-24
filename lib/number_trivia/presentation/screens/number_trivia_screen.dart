import 'package:flutter/material.dart';

import './../widgets/number_trivia_display.dart';
import './../widgets/number_trivia_control.dart';

class NumberTriviaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _triviaDisplayWidget(context),
            NumberTriviaControl(),
          ],
        ),
      ),
    );
  }

  Widget _triviaDisplayWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32),
      height: MediaQuery.of(context).size.height / 3,
      child: NumberTriviaDisplay(),
    );
  }
}
