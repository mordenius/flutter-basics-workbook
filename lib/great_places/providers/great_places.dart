import 'dart:io';

import 'package:flutter/foundation.dart';

import './../models/place.dart';
import './../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
  }

  void addPlace(String title, File image) {
    final id = DateTime.now().toIso8601String();

    _items.add(
      Place(
        id: id,
        title: title,
        image: image,
        location: PlaceLocation(
          lattitude: 0,
          longitude: 0,
        ),
      ),
    );

    notifyListeners();

    DBHelper.insert('places', {
      'id': id,
      'title': title,
      'image': image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final List<Map<String, dynamic>> dataPlaces =
        await DBHelper.getData('places');

    for (final dataPlace in dataPlaces) {
      _items.add(
        Place(
          id: dataPlace['id'],
          title: dataPlace['title'],
          image: File(dataPlace['image']),
          location: null,
        ),
      );
    }
  }
}
