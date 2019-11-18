import 'package:flutter/material.dart';

import './../models/place.dart';

import './map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static final String routeName = '/great-places/place-detail';

  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(title: Text(place.title)),
        body: Column(
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                place.location.address,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            FlatButton(
              child: Text('View on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) {
                      return MapScreen(
                        initialLocation: place.location,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ));
  }
}
