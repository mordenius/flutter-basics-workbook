import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../providers/quiz.provider.dart';
import './../models/question.model.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Quiz quiz = Provider.of<Quiz>(context);
    Question question = quiz.getQuestion();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    quiz.progress,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 32),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    question.text,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            child: Consumer<Quiz>(
              builder: (ctx, _quiz, _child) => GridView.builder(
                itemCount: question.answers.length,
                itemBuilder: (ctx, index) {
                  return GridTile(
                    child: RaisedButton(
                      child: Text(question.answers[index].text),
                      onPressed: () => quiz.next(question.answers[index]),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 1,
                    crossAxisSpacing: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
