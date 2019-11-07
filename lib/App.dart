import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text("Title ")),
        body: Column(
          children: [
            Text('Question?'),
            RaisedButton(
              child: Text("Answer 1"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("Answer 2"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("Answer 3"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("Answer 4"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
