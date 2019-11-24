import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../presentation/bloc/bloc.dart';

class NumberTriviaControl extends StatelessWidget {
  final numberInputController = TextEditingController();

  void _dispatchConcrete(BuildContext context) {
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(numberInputController.text));
    numberInputController.clear();
  }

  void _dispatchRandom(BuildContext context) {
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: numberInputController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) {
            _dispatchConcrete(context);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: RaisedButton(
                child: Text('Search'),
                color: Theme.of(context).accentColor,
                textTheme: Theme.of(context).buttonTheme.textTheme,
                onPressed: () {
                  _dispatchConcrete(context);
                },
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: RaisedButton(
                child: Text('Get random'),
                color: Theme.of(context).accentColor,
                textTheme: Theme.of(context).buttonTheme.textTheme,
                onPressed: () {
                  _dispatchRandom(context);
                },
              ),
            ),
            SizedBox(
              width: 8,
            ),
          ],
        ),
      ],
    );
  }
}
