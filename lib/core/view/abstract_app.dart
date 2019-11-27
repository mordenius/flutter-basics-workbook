import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbstractApp extends StatelessWidget {
  final ThemeData theme;
  final List<SingleChildCloneableWidget> providers;
  final Map<String, Widget Function(BuildContext)> routes;
  final Widget home;
  final Widget route404;

  AbstractApp(this.home,
      {Key key,
      @required this.theme,
      @required this.providers,
      @required this.routes,
      this.route404})
      : super(key: key);

  Route<dynamic> _onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => route404 ?? Route404());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        theme: theme,
        home: home,
        routes: routes,
        onUnknownRoute: _onUnknownRoute,
      ),
    );
  }
}

class Route404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unknown route')),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Text('404 page', style: TextStyle(fontSize: 30)),
      ),
    );
  }
}
