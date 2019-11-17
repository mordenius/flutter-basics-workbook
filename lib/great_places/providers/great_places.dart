import 'dart:io';

import 'package:flutter/foundation.dart';

import './../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
  }

  void addPlace(String title, File image) {
    _items.add(
      Place(
        id: DateTime.now().toIso8601String(),
        title: title,
        image: image,
        location: PlaceLocation(
          lattitude: 0,
          longitude: 0,
        ),
      ),
    );

    notifyListeners();
  }
}
