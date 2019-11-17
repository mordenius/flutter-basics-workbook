import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../providers/great_places.dart';

import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Great places app'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }),
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: Center(
          child: Text('Got no places yet, start adding some!'),
        ),
        builder: (ctx, greatPlaces, child) => Center(
          child: greatPlaces.items.length > 0
              ? ListView.builder(
                  itemCount: greatPlaces.items.length,
                  itemBuilder: (_ctx, index) => ListTile(
                    title: Text(greatPlaces.items[index].title),
                    leading: CircleAvatar(
                        backgroundImage: FileImage(
                      greatPlaces.items[index].image,
                    )),
                  ),
                )
              : child,
        ),
      ),
    );
  }
}
