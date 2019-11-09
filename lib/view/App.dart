import 'package:flutter/material.dart';

import './theme.dart';
import './router.dart';

class App extends StatelessWidget {
  final dynamic _domain;

  App(this._domain);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Router(this._domain),
    );
  }
}
