import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../domain/entities/number_trivia.dart';
import './../bloc/bloc.dart';

class NumberTriviaDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        if (state is InitialNumberTriviaState) {
          return _MessageWidget(message: 'Enter a Number');
        } else if (state is LoadingNumberTriviaState) {
          return CircularProgressIndicator();
        } else if (state is LoadedNumberTriviaState) {
          return _TriviaWidget(trivia: state.trivia);
        } else if (state is ErrorNumberTriviaState) {
          return _MessageWidget(message: state.message);
        }

        return _MessageWidget(message: 'Something went wrong.');
      },
    );
  }
}

class _TriviaWidget extends StatelessWidget {
  final NumberTrivia trivia;

  const _TriviaWidget({Key key, this.trivia}) : super(key: key);

  static const _testStyle = const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _centeredText(
          trivia.number.toString(),
          _testStyle,
        ),
        _MessageWidget(message: trivia.text),
      ],
    );
  }
}

class _MessageWidget extends StatelessWidget {
  final String message;

  const _MessageWidget({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: _centeredText(message),
      ),
    );
  }
}

Widget _centeredText(String message, [TextStyle style]) {
  return Text(
    message,
    style: style ??
        const TextStyle(
          fontSize: 25,
        ),
    textAlign: TextAlign.center,
  );
}
