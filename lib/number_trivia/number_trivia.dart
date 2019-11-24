import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './injection_container.dart' as di;
import './presentation/bloc/number_trivia_bloc.dart';
import './presentation/screens/number_trivia_screen.dart';

void main() {
  di.init().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: BlocProvider(
        builder: (_) => di.serviceLocator<NumberTriviaBloc>(),
        child: NumberTriviaScreen(),
      ),
    );
  }
}
