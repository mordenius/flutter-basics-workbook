import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../providers/quiz.provider.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Quiz quiz = Provider.of<Quiz>(context, listen: false);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Result of Quiz',
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 32),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
            ),
            OrientationBuilder(
              builder: (context, _orientation) {
                return SizedBox(
                  height: MediaQuery.of(context).orientation == Orientation.portrait ? 64 : 32,
                );
              },
            ),
            RaisedButton(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Reset Quiz",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              onPressed: () {
                quiz.reset();
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );;
  }
}
