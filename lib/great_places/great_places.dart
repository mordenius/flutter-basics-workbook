import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/great_places.dart';

import './theme.dart';

import './screens/places_list_screen.dart';

class GreatPlacesApp extends StatelessWidget {
  static final List<SingleChildCloneableWidget> _providers = [
    ChangeNotifierProvider.value(value: GreatPlaces()),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: MaterialApp(
        theme: greatPlacesTheme,
        home: _GreatPlacesApp(),
      ),
    );
  }
}

class _GreatPlacesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlacesListScreen(),
    );
  }
}
