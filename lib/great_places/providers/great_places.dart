import 'dart:io';

import 'package:flutter/foundation.dart';

import './../models/place.dart';
import './../helpers/db_helper.dart';
import './../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final id = DateTime.now().toIso8601String();

    final String address = await LocationHelper.getPlaceAddress(
        latitude: location.lattitude, longitude: location.longitude);
    _items.add(
      Place(
        id: id,
        title: title,
        image: image,
        location: PlaceLocation(
            lattitude: location.lattitude,
            longitude: location.longitude,
            address: address),
      ),
    );

    notifyListeners();

    DBHelper.insert('places', {
      'id': id,
      'title': title,
      'image': image.path,
      'loc_lat': location.lattitude,
      'loc_lng': location.longitude,
      'address': address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final List<Map<String, dynamic>> dataPlaces =
        await DBHelper.getData('places');

    List<Place> items = [];

    for (final dataPlace in dataPlaces) {
      items.add(
        Place(
          id: dataPlace['id'],
          title: dataPlace['title'],
          image: File(dataPlace['image']),
          location: PlaceLocation(
              lattitude: dataPlace['loc_lat'],
              longitude: dataPlace['loc_lng'],
              address: dataPlace['address']),
        ),
      );
    }

    _items = items;
  }
}
