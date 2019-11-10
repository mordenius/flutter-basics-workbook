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
      routes: routes,
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text('Unknown route')),
            body: Container(
              margin: EdgeInsets.all(20),
              child: Text('404 page', style: TextStyle(fontSize: 30)),
            ),
          ),
        );
      },
    );
  }
}
