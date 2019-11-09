import 'package:flutter/material.dart';


import './Router.dart';

class App extends StatelessWidget {
  final dynamic _domain;

  App(this._domain);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: "Quicksand",
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.dark().textTheme.copyWith(
                      title: TextStyle(
                        fontFamily: "Quicksand",
                        fontSize: 18,
                      ),
                    ))),
        home: Router(this._domain));
  }
}
