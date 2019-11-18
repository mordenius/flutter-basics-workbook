import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../providers/great_places.dart';
import './../widgets/image_input.dart';
import './../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routeName = '/great-places/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _picture;

  void _selectImage(File picture) {
    _picture = picture;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _picture == null) {
      return;
    }

    final GreatPlaces greatPlaces =
        Provider.of<GreatPlaces>(context, listen: false);
    greatPlaces.addPlace(_titleController.text, _picture);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add place')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 16),
                    ImageInput(onSelectImage: _selectImage),
                    SizedBox(height: 16),
                    LocationInput(onSelectLocation: null),
                  ],
                ),
              ),
            ),
            RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Place'),
              onPressed: _savePlace,
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).accentColor,
            )
          ],
        ));
  }
}
