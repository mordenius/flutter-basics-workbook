import 'dart:io';

import 'package:flutter/material.dart';

import './../widgets/image_input.dart';

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
